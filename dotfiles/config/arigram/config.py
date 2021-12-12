import os
import time
from threading import Thread
from urllib.parse import quote as url_safe
from re import escape as escape_special
from timeit import default_timer as timer

import arigram
import pyfzf
import wikipedia
from arigram import config as tg_config
from arigram.controllers import msg_handler
from arigram.tdlib import TextParseModeInput
from arigram.utils import is_yes, suspend
from plyer import notification
from simpleaudio import WaveObject


class Custom:
    def _play_wav(self, wave_path: str) -> Thread:
        def player() -> None:
            wave_obj = WaveObject.from_wave_file(wave_path)
            play_obj = wave_obj.play()
            play_obj.wait_done()

        sound = Thread(target=player)
        sound.setDaemon(True)

        return sound

    def _notify(self, title: str, message: str) -> Thread:
        def notifier() -> None:
            if notification.notify is not None:
                notification.notify(
                    app_name=f"arigram {arigram.__version__}",
                    title=title,
                    message=message,
                )

        notif = Thread(target=notifier)
        notif.setDaemon(True)

        return notif

    def _is_locked(self, lockfile: str = "/tmp/arigram.lock") -> bool:
        return os.path.exists(lockfile)

    def notify(self, *args, **kwargs) -> None:
        del args

        self._notify(str(kwargs.get("title")), str(kwargs.get("msg"))).start()
        self._play_wav(f"{tg_config.CONFIG_DIR}resources/notification.wav").start()

    def batch_delete(self, ctrl, *args) -> None:
        del args

        lockfile = "/tmp/arigram-delete.lock"

        if self._is_locked(lockfile):
            return

        def killer(sleep_time: float, many: int, __total: int = 0):
            if self._is_locked(lockfile):
                return __total
            else:
                open(lockfile, "w").close()

            count = many
            total = __total

            for _ in range(many):
                try:
                    is_deleted = ctrl.model.delete_msgs()
                    ctrl.discard_selected_msgs()

                    if not is_deleted:
                        ctrl.prev_msg()

                        if not ctrl.model.has_prev_message():
                            count = 0
                            break

                        continue
                except (IndexError, KeyError):
                    count = 0
                    break

                time.sleep(sleep_time)

                count -= 1
                total += 1

            os.remove(lockfile)
            if count > 0:
                return killer(sleep_time, count, total)

            return total

        max_deletion = int(ctrl.view.status.get_input("how many to delete (int)"))
        sleep_time = float(
            ctrl.view.status.get_input("every valid deletion sleep (float in s)")
        )

        start = timer()
        total = killer(sleep_time, max_deletion)
        end = timer()

        ctrl.model.send_message(
                text=f"[ARIGRAM] Deleted {total}/{max_deletion} messages with delay of {sleep_time}s in {(end - start):.3f}s"
        )

    def batch_send(self, ctrl, *args) -> None:
        del args

        lockfile = "/tmp/arigram-send.lock"

        if self._is_locked(lockfile):
            return

        def sender(sleep_time: float, many: int, string: str, __total: int = 0):
            if self._is_locked(lockfile):
                return __total
            else:
                open(lockfile, "w").close()

            count = many
            total = __total

            for _ in range(many):
                ctrl.model.send_message(string)

                time.sleep(sleep_time)

                count -= 1
                total += 1

            os.remove(lockfile)
            if count > 0:
                return sender(sleep_time, count, string, total)

            return total

        max_sending = int(ctrl.view.status.get_input("how many to send (int)"))
        string = ctrl.view.status.get_input("what to send (str)")
        sleep_time = float(
            ctrl.view.status.get_input("every valid message sent sleep (float in s)")
        )

        start = timer()
        total = sender(sleep_time, max_sending, string)
        end = timer()

        ctrl.model.send_message(text=f"[ARIGRAM] Sent {total}/{max_sending} messages with delay of {sleep_time}s in {(end - start):.3f}s")

    @staticmethod
    def send_reversed(ctrl, *args) -> None:
        del args
        ctrl.model.send_message(ctrl.view.status.get_input("reversed message")[::-1])

    @staticmethod
    def send_countdown(ctrl, *args) -> None:
        del args
        max_count = ctrl.view.status.get_input("countdown")

        for count in reversed(range(1, int(max_count) + 1)):
            ctrl.model.send_message(str(count))
            time.sleep(1)

    @staticmethod
    def send_wiki(ctrl, *args) -> None:
        del args

        search = ctrl.view.status.get_input("wikipedia query")

        if not search:
            ctrl.present_info("Query canceled")
            return

        query_results = wikipedia.search(search)

        if not search:
            ctrl.present_info("Query canceled")
            return

        with suspend(ctrl.view):
            article_name = pyfzf.FzfPrompt().prompt(
                query_results, f"--prompt='Results about <{search}>: '"
            )

        article_page = wikipedia.page(article_name)

        resp = ctrl.view.status.get_input(
            f"send wikipedia article about <{article_page.title}>? (Y/n)"
        )

        if not is_yes(resp):
            ctrl.present_info(f"Discarding article about <{article_page.title}>")
            return

        message_content = f"""[Wikipedia: {escape_special(article_page.title)}](https://en.wikipedia.org/wiki/{url_safe(article_page.title)})

```
{article_page.summary[:200]}...
```
"""
        ctrl.model.send_message(message_content)


custom_code = Custom()

NOTIFY_FUNCTION = custom_code.notify
CUSTOM_KEYBINDS = {
    "z": {"func": custom_code.batch_delete, "handler": msg_handler},
    "x": {"func": custom_code.batch_send, "handler": msg_handler},
    "C": {"func": custom_code.send_reversed, "handler": msg_handler},
    "w": {"func": custom_code.send_wiki, "handler": msg_handler},
    "B": {"func": custom_code.send_countdown, "handler": msg_handler},
}
DEFAULT_OPEN = tg_config.LONG_MSG_CMD
EXTRA_TDLIB_HEADEARS = {
    "disable_web_page_preview": True,
    "parse_mode": {
        "@type": TextParseModeInput.textParseModeMarkdown.name,
        "version": 2,
    },
}
