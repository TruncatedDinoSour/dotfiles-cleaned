fun! MakeNewPythonFile()
    put ='#!/usr/bin/env python3'
    put =''
    put =''
    put ='import asyncio'
    put =''
    put =''
    put ='async def main() -> int:'
    put ='    _'
    put ='    return 0'
    put =''
    put =''
    put ='if __name__ == \"__main__\":'
    put ='    assert main.__annotations__.get(\"return\") is int, \"main() should return an integer\"'
    put ='    exit(asyncio.run(main()))'
    put =''
    norm ggdd
endfun

augroup NewPythonFile
    autocmd!
    inoremap main :call MakeNewPythonFile()
augroup END

