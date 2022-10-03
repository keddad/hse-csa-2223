import pytest
import sys
import itertools
from subprocess import run, PIPE, STDOUT
from pathlib import Path

binaries = ["ref", "ref_commented"]

tests = [((1, 2, 3), (2, 2, 2)),
         ((-1, -2, -3), (4, 3, 2)),
         ((-1, 0, 1), (4, 0, 2))]

params = list(itertools.product(binaries, tests))


@pytest.mark.parametrize("bin, data", params)
def test_stdin(bin, data):
    arr = data[0]
    answ = data[1]

    p = run(f"./{bin} c {len(arr)}",
            input=(" ".join([str(x) for x in arr]).encode()), stdout=PIPE, shell=True)

    assert p.stdout.decode().rstrip() == " ".join([str(x) for x in answ])


@pytest.mark.parametrize("bin, data", params)
def test_files(bin, data):
    arr = data[0]
    answ = data[1]

    Path("test_input_file.txt").write_text(" ".join([str(x) for x in arr]))

    p = run(f"./{bin} f {len(arr)} test_input_file.txt test_output_file.txt",
            input=(" ".join([str(x) for x in arr]).encode()), stdout=PIPE, shell=True)

    assert Path("test_output_file.txt").read_text(
    ).rstrip() == " ".join([str(x) for x in answ])

    Path("test_input_file.txt").unlink()
    Path("test_output_file.txt").unlink()


if __name__ == "__main__":
    pytest.main()
