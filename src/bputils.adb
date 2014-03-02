-------------------------------------------------------------------------------
-- File Name   : bputils.adb
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Provides the package body and definitions for the utility
--               functions deescribed in BPUTILS.
--
-- Dependency  : Package BPCONSTS must be defined.
-------------------------------------------------------------------------------

With Ada.Text_IO;
Use Ada.Text_IO;

With BPCONSTS;

package body BPUTILS is

-------------------------------------------------------------------------------
-- Function    : Pad_with_spaces
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Fills the rest of the input string with spaces upto a given
--               maximum length. Creates a temporary string of remaining
--               length and concatenates it to the original string.
--
-- Parameters  : <input> Str_to_pad -- the string to be padded
--               <input> Max_length -- maximum required length
--
-- Return      : Padded_String
-------------------------------------------------------------------------------
   function Pad_with_spaces
     (Str_to_pad : in String;
      Max_length : in Natural) return String is

      Padded_String : String (1..Max_length); -- return string
      Added_string  : String (1..Max_length - Str_to_pad'Length);

   begin

      for Idx in Added_string'range loop
         Added_string(Idx) := ' ';
      end loop;

      Padded_string := Str_to_pad & Added_string;

      return Padded_string;

   end;

-------------------------------------------------------------------------------
-- Procedure   : Make_token_array
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Divides the input string into tokens which are present in the
--               input string, separated by a delimiter.
--
-- Parameters  : <input> Input_str : String to be divided
--               <input> Length : Length of the input string
--               <input> Max_count : Maximum numer of tokens to be extracted
--               <output> Tokens : The created array of tokens
--               <output> Count : The number of tokens extracted
-------------------------------------------------------------------------------
   procedure Make_token_array
     (Input_str : in String;
      Length    : in Positive;
      Max_count : in Positive;
      Tokens    : out Token_Array;
      Count     : out Natural) is

      Token_idx   : Positive := 1;
      Index_prev  : Natural := 1;

   begin

      Count := 0;

      -- Initialize the tokens
      for Index in 1..Max_count loop
         Tokens(Index) := SU.To_unbounded_string("");
      end loop;

      for Index in 1..Length loop

         if Input_str(Index) = BPCONSTS.DELIMITER then

            -- Slice the string from the index of the previous
            -- occurence of the delimiter to the current occurance
            Tokens(Token_idx) :=
              SU.To_Unbounded_String(Input_str(Index_prev..Index-1));

            Token_idx := Token_idx + 1;
            Index_prev := Index + 1;

         end if;

      end loop;

      Count := Token_idx - 1;

   end;

end BPUTILS;
