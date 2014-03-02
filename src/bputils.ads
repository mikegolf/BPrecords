-------------------------------------------------------------------------------
-- File Name   : bputils.ads
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Contains the package BPUTILS which describes the data records
--               and utility functions used in the component.
--
-- Dependency  : Package BPCONSTS must be defined.
-------------------------------------------------------------------------------

With Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with BPCONSTS;

package BPUTILS is

   package SU renames Ada.Strings.Unbounded;

   -- Record containing blood pressure data

   type BP_Pair is record
      Systolic  : Positive;
      Diastolic : Positive;
   end record;

   -- Array of blood pressure data pairs

   type BP_Array is array (Positive range <>) of BP_Pair;

   type BP_List (Max_length : Positive) is record
      Num_records : Natural;
      Records     : BP_Array (1..Max_length);
   end record;

   -- Patiend information record linking the bood pressure
   -- records with the patient name and an assigned identification

   type Patient_Record is record
      Patient_id   : String(1..BPCONSTS.ID_LENGTH);
      Patient_name : String(1..BPCONSTS.NAME_LENGTH);
      BP_record    : BP_List(BPCONSTS.MAX_BP_VALUES);
   end record;

   -- Function to pad an input string with spaces on the right
   -- Possible improvement : Choice of padding to right or left

   function Pad_with_spaces
     (Str_to_pad : in String;
      Max_length : in Natural) return String;

   -- A utility array of string tokens

   type Token_Array is array (Positive range <>) of SU.Unbounded_String;

   -- Function to convert an input string into an array of string tokens
   -- Original input string contains the token strings separated by a
   -- delimiter specified in the package BPCONSTS.

   procedure Make_token_array
     (Input_str : in String;
      Length    : in Positive;
      Max_count : in Positive;
      Tokens    : out Token_Array;
      Count     : out Natural);

end BPUTILS;
