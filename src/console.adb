-------------------------------------------------------------------------------
-- File Name   : console.adb
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Provides the package body and definitions for the application
--               procedures deescribed in the package CONSOLE.
--
-- Dependency  : Package BPCONSTS must be defined.
-------------------------------------------------------------------------------

With ADA.Text_IO;
Use ADA.Text_IO;

With BPCONSTS;
With BPUTILS;
Use BPUTILS;
With TEXTDB;

package body CONSOLE is

-------------------------------------------------------------------------------
-- Procedure   : View_record
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Lets the user input a patient id to fetch the records for and
--               displays the patient name associated with that id and lists
--               the patients record of systolic and diastolic blood pressure
--               values on the standard output.
--
-- Parameters  : None.
-------------------------------------------------------------------------------
   procedure View_record is

      Input_string : String (1..20);
      last         : Natural;
      Lookup_id    : String(1..BPCONSTS.ID_LENGTH);
      Data         : Patient_Record;
      Found        : Boolean;

   begin
      Put("Enter Patient Id >");

      Get_Line(Input_string, last);

      if (last <= 5) then
         Lookup_id := Pad_with_spaces(Input_string(1..last), 5);

         -- Using text based data operations.
         -- Can be replaced with advanced database options such as a
         -- relational database query or XML based services

         TEXTDB.Read_patient_record(Lookup_id, Data, Found);

         if Found = True then

            New_line;
            Put_Line("Blood Pressure records for " & Data.Patient_name);
            Put_Line("Systolic : Diastolic");

            for Index in 1..Data.BP_record.Num_records loop
               Put_Line("   " & Integer'Image(Data.BP_record.Records(Index).Systolic) &
                        "  : " &
                        Integer'Image(Data.BP_record.Records(Index).Diastolic));
            end loop;

         else
            Put_Line ("Cannot find patient with id = " & Lookup_id);
         end if;

      end if;

   end View_record;

-------------------------------------------------------------------------------
-- Procedure   : Add_record
-- Author      : Mayank
-- Created     : 28/02/2014
--
-- Description : Lets the user input patient data along with an id and name
--               followed by a number of blood pressure data via standatd
--               input. Stores the input in a local record and uses TEXTDB
--               write functions to store that data into the data store
--
-- Parameters  : None.
-------------------------------------------------------------------------------
   procedure Add_record is

      Input_string : String (1..20);
      last         : Natural;
      Data         : Patient_Record;
      BP_Data      : BP_List (BPCONSTS.MAX_BP_VALUES);
      Index        : Positive := 1;

   begin
      Put_Line("Making new record");
      Put("Enter patient id >");
      Get_Line(Input_string, last);

      if (last <= BPCONSTS.ID_LENGTH) then
         Data.Patient_id := Pad_with_spaces(Input_string(1..last),
                                            BPCONSTS.ID_LENGTH);
      end if;

      Put("Enter patient name >");
      Get_Line(Input_string, last);

      if (last <= BPCONSTS.NAME_LENGTH) then
         Data.Patient_name := Pad_with_spaces(Input_string(1..last),
                                              BPCONSTS.NAME_LENGTH);
      end if;

      Put("Enter number of BP recordings >");
      Get_Line(Input_string, last);

      if (last <= BPCONSTS.NUM_BP_LENGTH) then
         BP_Data.Num_records := Integer'Value(Input_string(1..last));
      end if;

      while Index <= BP_Data.Num_records loop
         Put("Systolic >");
         Get_Line(Input_string, last);

         if (last <= BPCONSTS.BP_VAL_LENGTH) then
            BP_Data.Records(Index).Systolic :=
              Positive'Value(Input_string(1..last));
         end if;

         Put("Diastolic >");
         Get_Line(Input_string, last);

         if (last <= BPCONSTS.BP_VAL_LENGTH) then
            BP_Data.Records(Index).Diastolic :=
              Positive'Value(Input_string(1..last));
         end if;

         Index := Index + 1;

      end loop;

      Data.BP_record := BP_Data;

      -- Using text based data operations.

      TEXTDB.Write_patient_record(Data);

   end Add_record;

end CONSOLE;
