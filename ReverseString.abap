CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.
CLASS zcl_reverse_string IMPLEMENTATION.
  METHOD reverse_string.
    " Please complete the implementation of the reverse_string method
    result = reverse( input ).
  ENDMETHOD.
ENDCLASS.

###TEST CASE###
CLASS ltcl_reverse_string DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.
  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_reverse_string.
    METHODS:
      setup,
      test_empty_string FOR TESTING,
      test_word FOR TESTING,
      test_capitalized_word FOR TESTING,
      test_sentence_with_punctuation FOR TESTING,
      test_palindrome FOR TESTING,
      test_even_sized_word FOR TESTING.
ENDCLASS.
CLASS ltcl_reverse_string IMPLEMENTATION.
  METHOD setup.
    cut = NEW zcl_reverse_string( ).
  ENDMETHOD.
  METHOD test_empty_string.
    cl_abap_unit_assert=>assert_equals(
      act = cut->reverse_string( '' )
      exp = '' ).
  ENDMETHOD.
