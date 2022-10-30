import pytest
import sys
import itertools
from subprocess import run, PIPE, STDOUT
from pathlib import Path

binaries = ["ref", "ref_commented", "ref_regopt"]

tests = [("abc\ncde\n", "ab\nde"),
         ("aaa\naaa", ""),
         ("abc\ndef", "\nabc\ndef")]

params = list(itertools.product(binaries, tests))

@pytest.mark.parametrize("bin, data", params)
def test_stdin(bin, data):
    query = data[0]
    answ = data[1]

    p = run(f"./{bin} c",
            input=(query.encode()), stdout=PIPE, shell=True)

    assert p.stdout.decode().rstrip() == answ


@pytest.mark.parametrize("bin, data", params)
def test_files(bin, data):
    query = data[0]
    answ = data[1]

    Path("test_input_file.txt").write_text(query)

    p = run(f"./{bin} f test_input_file.txt test_output_file.txt", shell=True)

    assert Path("test_output_file.txt").read_text(
    ).rstrip() == answ

    Path("test_input_file.txt").unlink()
    Path("test_output_file.txt").unlink()


if __name__ == "__main__":
    pytest.main()
