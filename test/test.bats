setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
    # ... the remaining setup is unchanged

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH"
}

@test "can run our script" {
    run project.sh # notice `run`!
    assert_output --partial 'Welcome to our project!'
}

@test "refute suma" {
    result=$((2+2))
    refute [ "$result" -eq 5 ]
}

@test "check suma" {
    result=$((2+2))
    assert [ "$result" -eq 4 ]
}

@test "check iguales" {
    result=$((2+2))
    assert_equal "$result" 5
}

@test "invoking foo with a nonexistent file prints an error" {
    skip "Not implemented yet"
  run foo nonexistent_filename
  [ "$status" -eq 1 ]
  [ "$output" = "foo: no such file 'nonexistent_filename'" ]
  [ "$BATS_RUN_COMMAND" = "foo nonexistent_filename" ]
}

@test "Debería ejecutar un script" {
    assert_file_executable ./src/sample.sh
    sample.sh 'Hello ' 'Baeldung' '/tmp/output'
}

@test "Debería devolver una frase" {
    run sample.sh 'Hola ' 'Lorenzo' '/tmp/output'
    assert_output 'Hola Lorenzo'
    assert_output --partial 'Lorenzo'
    refute_output 'Hola Mundo!!'
}

@test "deberia crear un archivo" {
    run sample.sh 'Hola ' 'Lorenzo' '/tmp/output'
    assert_exist /tmp/output
}
