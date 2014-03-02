-------------------------------------------------------------------------------
-- File Name   : textdb.adb
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Contains the definition of procedures in the package TEXTDB
--               to read from and write to a text based record of patients'
--               blood pressure data.
--
-- Dependency  : Packages BPCONSTS, BPUTILS must be defined.
-------------------------------------------------------------------------------

With ADA.Text_IO;
Use ADA.Text_IO;
With BPCONSTS;
With BPUTILS;

package body TEXTDB is

-------------------------------------------------------------------------------
-- Procedure   : Read_patient_record
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Takes a patient Id as input and outputs a created Patient
--               record structure corresponding to that id along with a
--               boolean stating whether data was found.
--
-- Parameters  : <input> Patient_id: id to search for
--               <output> Data : Patient record to be filled.
--               <output> Found : Boolean true if record is found
-------------------------------------------------------------------------------
   procedure Read_patient_record

     (Patient_id : in String;
      Data       : out Patient_record;
      Found      : out Boolean)

   is

      file               : File_Type;
      Header_length      : Natural := 0;
      Data_length        : Natural := 0;
      Header_buf         : String (1..BPCONSTS.MAX_BUFFER_LENGTH);
      Data_buf           : String (1..BPCONSTS.MAX_BUFFER_LENGTH);
      Header_token_count : Natural := 0;
      Data_token_count   : Natural := 0;
      Header_tokens      : Token_array(1..BPCONSTS.MAX_HEADER_TOKENS);
      Data_tokens        : Token_array(1..BPCONSTS.MAX_DATA_TOKENS);
      Index_prev         : Natural := 1;
      BP_Data            : BP_List (BPCONSTS.MAX_BP_VALUES);

   begin

      Put_Line ("Looking for patient with ID = " & Patient_id);
      Found := False;

      Open(file, In_File, BPCONSTS.BP_FILE_NAME);

      while not End_of_File (file)
      loop

         -- Read a line from the file
         Get_Line (file, Header_buf, Header_length);

         Header_token_count := 0;
         Index_prev := 1;

         -- Extract individual string tokens from the line
         Make_token_array(Header_buf,
                          Header_length,
                          BPCONSTS.MAX_HEADER_TOKENS,
                          Header_tokens,
                          Header_token_count);

         -- If this is a header line i.e. a line with 3 tokens
         -- and the first token matches the id input by user,
         -- store the name and read the next lines for BP data
         if Header_token_count = BPCONSTS.MAX_HEADER_TOKENS and
            Patient_id =  SU.To_String(Header_tokens(1)) then

            Found := True;

            Data.Patient_id :=
              Pad_with_spaces(SU.To_String(Header_tokens(1)),
                              BPCONSTS.ID_LENGTH);

            Data.Patient_name :=
              Pad_with_spaces(SU.To_String(Header_tokens(2)),
                                           BPCONSTS.NAME_LENGTH);

            BP_Data.Num_records := Integer'Value(SU.To_String(Header_tokens(3)));

            -- Read the next Num_records number of lines which will
            -- contain the BP data pairs.
            for BP_Index in 1 .. BP_Data.Num_records loop

               Get_Line (file, Data_buf, Data_length);

               Make_token_array(Data_buf,
                                Data_length,
                                BPCONSTS.MAX_DATA_TOKENS,
                                Data_tokens,
                                Data_token_count);

               if Data_token_count = BPCONSTS.MAX_DATA_TOKENS then

                  -- Store BP data in record
                  BP_data.Records(BP_Index).Systolic :=
                    Integer'Value(SU.To_String(Data_tokens(1)));

                  BP_data.Records(BP_Index).Diastolic :=
                    Integer'Value(SU.To_String(Data_tokens(2)));

               end if;

            end loop; -- BP data lines for the found patient

            Data.BP_record := BP_data;

         end if;

      end loop; -- file read line by line

      Close(file);

   end Read_patient_record;

-------------------------------------------------------------------------------
-- Procedure   : Write_patient_record
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Takes a patient record as input and writes the data in the
--               text based data store in the correct format.
--
-- Parameters  : <input> Data : Patient record to be stored.
-------------------------------------------------------------------------------

   procedure Write_patient_record
     (Data : in Patient_record ) is

      file       : File_Type;
      Sys_str    : String (1..BPCONSTS.BP_VAL_LENGTH);
      Dia_str    : String (1..BPCONSTS.BP_VAL_LENGTH);
      Num_String : String (1..BPCONSTS.NUM_BP_LENGTH);
      Header_str : String (1..(BPCONSTS.ID_LENGTH + 1 +
                               BPCONSTS.NAME_LENGTH + 1 +
                               BPCONSTS.NUM_BP_LENGTH + 1 ));
      Data_str   : String (1..(BPCONSTS.BP_VAL_LENGTH + 1 +
                               BPCONSTS.BP_VAL_LENGTH + 1));

   begin

      Num_string :=
        Pad_with_spaces(ASF.Trim(
                          Integer'Image(Data
                            .BP_record
                            .Num_records),
                          ADA.Strings.Left),
                        BPCONSTS.NUM_BP_LENGTH);

      -- Create the header string
      Header_str := (Data.Patient_id & BPCONSTS.DELIMITER &
                     Data.Patient_name & BPCONSTS.DELIMITER &
                     Num_string & BPCONSTS.DELIMITER);

      Open( file, Append_File, BPCONSTS.BP_FILE_NAME);

      -- Write header line to file
      Put_Line(file, Header_str);

      for Index in 1..Data.BP_record.Num_records loop

         -- Create the Data strings
         Sys_str :=
           Pad_with_spaces(ASF.Trim(
                             Integer'Image(Data
                               .BP_record
                               .Records(Index)
                               .Systolic),
                             Ada.Strings.Left),
                           BPCONSTS.BP_VAL_LENGTH);

         Dia_str :=
           Pad_with_spaces(ASF.Trim(
                             Integer'Image(Data
                               .BP_record
                               .Records(Index)
                               .Diastolic),
                             Ada.Strings.Left),
                           BPCONSTS.BP_VAL_LENGTH);

         Data_str :=
           (Sys_str & BPCONSTS.DELIMITER &
            Dia_str & BPCONSTS.DELIMITER);

         -- Write data line to file
         Put_Line(file, Data_str);

      end loop;

      Close(file);

   end Write_patient_record;

end TEXTDB;
