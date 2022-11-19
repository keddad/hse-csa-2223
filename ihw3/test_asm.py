import pytest
import sys
import itertools
from subprocess import run, PIPE, STDOUT
from pathlib import Path

def f(x):
    return 1 / (1 - x)

binaries = ["ref", "ref_commented", "ref_regopt", "manyfiles", "ref_speed", "ref_size"]

tests = [(x, f(x)) for x in [-0.5, -0.4, -0.3, -0.001, 0.0004, 0.5]]

params = list(itertools.product(binaries, tests))

@pytest.mark.parametrize("bin, data", params)
def test_stdin(bin, data):
    query = data[0]
    answ = data[1]

    p = run(f"./{bin} c",
            input=(str(query).encode()), stdout=PIPE, shell=True)

    assert float(p.stdout.decode().rstrip()) == pytest.approx(answ, rel=1e-2)


@pytest.mark.parametrize("bin, data", params)
def test_files(bin, data):
    query = data[0]
    answ = data[1]

    Path("test_input_file.txt").write_text(str(query))

    p = run(f"./{bin} f test_input_file.txt test_output_file.txt", shell=True)

    assert float(Path("test_output_file.txt").read_text(
    ).rstrip()) == pytest.approx(answ, rel=1e-2)

    Path("test_input_file.txt").unlink()
    Path("test_output_file.txt").unlink()


if __name__ == "__main__":
    pytest.main()
