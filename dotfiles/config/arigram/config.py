import os
import time
from threading import Thread

import arigram
from arigram import config as tg_config
from arigram.controllers import msg_handler
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

    def notify(self, *args, **kwargs) -> None:
        del args

        self._notify(str(kwargs.get("title")), str(kwargs.get("msg"))).start()
        self._play_wav(f"{tg_config.CONFIG_DIR}resources/notification.wav").start()

    @staticmethod
    def batch_delete(ctrl, *args) -> None:
        del args

        lockfile = "/tmp/arigram-delete-lock"

        if os.path.exists(lockfile):
            return

        def killer(many: int, __total: int = 0):
            if os.path.exists(lockfile):
                return __total
            else:
                open(lockfile, "w").close()

            count = many
            total = __total

            for _ in range(many):
                time.sleep(2)

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

                count -= 1
                total += 1

            os.remove(lockfile)
            if count > 0:
                return killer(count, total)

            return total

        max_deletion = int(ctrl.view.status.get_input("How many to delete (int): "))
        total = killer(max_deletion)
        ctrl.model.send_message(text=f"\[BOT\] Deleted {total}/{max_deletion} messages")


custom_code = Custom()

NOTIFY_FUNCTION = custom_code.notify
CUSTOM_KEYBINDS = {"z": {"func": custom_code.batch_delete, "handler": msg_handler}}
DEFAULT_OPEN = "vim -- {file_path}"
