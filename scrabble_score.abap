CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    " add solution here
    DATA: lv_char  TYPE c LENGTH 1,
          lv_score TYPE i VALUE 0,
          lv_index type i.
    result = 0.

    " Convert the input to uppercase to handle both upper and lower case letters
    input = to_upper( input ).

    " Loop through each character in the input string
    DO STRLEN( input ) TIMES.
      lv_index = sy-index - 1.
      lv_char = input+lv_index(1). " Get each character

      CASE lv_char.
        WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
          lv_score = 1.
        WHEN 'D' OR 'G'.
          lv_score = 2.
        WHEN 'B' OR 'C' OR 'M' OR 'P'.
          lv_score = 3.
        WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
          lv_score = 4.
        WHEN 'K'.
          lv_score = 5.
        WHEN 'J' OR 'X'.
          lv_score = 8.
        WHEN 'Q' OR 'Z'.
          lv_score = 10.
        WHEN OTHERS.
          lv_score = 0. " In case the input contains a non-letter character
      ENDCASE.

      result = result + lv_score. " Add the score to the total result
    enddo.
  ENDMETHOD.

ENDCLASS.

###Test Case ###
CLASS ltcl_scrabble_score DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.
  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_scrabble_score.
    METHODS setup.
    METHODS test_lowercase_letter FOR TESTING RAISING cx_static_check.
    METHODS test_uppercase_letter FOR TESTING RAISING cx_static_check.
    METHODS test_valuable_letter FOR TESTING RAISING cx_static_check.
    METHODS test_short_word FOR TESTING RAISING cx_static_check.
    METHODS test_short_valuable_word FOR TESTING RAISING cx_static_check.
    METHODS test_medium_word FOR TESTING RAISING cx_static_check.
    METHODS test_medium_valuable_word FOR TESTING RAISING cx_static_check.
    METHODS test_long_mixed_case_word FOR TESTING RAISING cx_static_check.
    METHODS test_english_like_word FOR TESTING RAISING cx_static_check.
    METHODS test_empty_input FOR TESTING RAISING cx_static_check.
    METHODS test_entire_alphabet_available FOR TESTING RAISING cx_static_check.
ENDCLASS.
CLASS ltcl_scrabble_score IMPLEMENTATION.
  METHOD setup.
    cut = NEW zcl_scrabble_score( ).
  ENDMETHOD.
  " lowercase letter
  METHOD test_lowercase_letter.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'a' )
      exp = 1 ).
  ENDMETHOD.
  " uppercase letter
  METHOD test_uppercase_letter.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'A' )
      exp = 1 ).
  ENDMETHOD.
  " valuable letter
  METHOD test_valuable_letter.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'f' )
      exp = 4 ).
  ENDMETHOD.
  " short word
  METHOD test_short_word.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'at' )
      exp = 2 ).
  ENDMETHOD.
  " short, valuable word
  METHOD test_short_valuable_word.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'zoo' )
      exp = 12 ).
  ENDMETHOD.
  " medium word
  METHOD test_medium_word.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'street' )
      exp = 6 ).
  ENDMETHOD.
  " medium, valuable word
  METHOD test_medium_valuable_word.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'quirky' )
      exp = 22 ).
  ENDMETHOD.
  " long, mixed-case word
  METHOD test_long_mixed_case_word.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'OxyphenButazone' )
      exp = 41 ).
  ENDMETHOD.
  " english-like word
  METHOD test_english_like_word.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'pinata' )
      exp = 8 ).
  ENDMETHOD.
  " empty input
  METHOD test_empty_input.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( '' )
      exp = 0 ).
  ENDMETHOD.
  " entire alphabet available
  METHOD test_entire_alphabet_available.
    cl_abap_unit_assert=>assert_equals(
      act = cut->score( 'abcdefghijklmnopqrstuvwxyz' )
      exp = 87 ).
  ENDMETHOD.
ENDCLASS.
