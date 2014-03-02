-------------------------------------------------------------------------------
-- File Name   : textdb.ads
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Contains the package TEXTDB which provides the procedures
--               to read from and write to a text based record of patients'
--               blood pressure data.
--
--               The text based record is to be in a format where every
--               patient's data is described with a header and data following
--               the header. The header contains the patient id, name and the
--               number of data records, separated by a delimiter ";".
--               The data records are simply pairs of systolic and diastolic
--               BP values
--
--               Text file format:
--               -----------------
--
--               The header consists of:
--               ID   : Patient id : 5 characters max
--               NAME : Patient name : 20 characters max
--               NUM  : Number of BP records to follow : 3 characters max
--
--               The data consists of:
--               Systolic value  : 3 characters max
--               Diastolic value : 3 characters max
--
--
-- Dependency  : Packages BPCONSTS, BPUTILS must be defined.
-------------------------------------------------------------------------------
With ADA.Strings.Fixed;
With BPUTILS;
Use BPUTILS;

package TEXTDB is

   package ASF renames ADA.Strings.Fixed;

   procedure Read_patient_record
     (Patient_id : in String;
      Data       : out Patient_Record;
      Found      : out Boolean);

   procedure Write_patient_record
     (Data : in Patient_Record);

end TEXTDB;
