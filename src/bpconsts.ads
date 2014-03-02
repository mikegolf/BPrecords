-------------------------------------------------------------------------------
-- File Name   : bpconsts.ads
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Contains the package BPCONSTS which describes the constants
--               used throughout the component.
--
-- Dependency  : None
-------------------------------------------------------------------------------

package BPCONSTS is

   BP_FILE_NAME  : constant String := "BP_Data.txt";

   -- Constants for data description
   ID_LENGTH     : constant Positive := 5;
   NAME_LENGTH   : constant Positive := 20;
   NUM_BP_LENGTH : constant Positive := 3;
   BP_VAL_LENGTH : constant Positive := 3;
   MAX_BP_VALUES : constant Positive := 500;

   -- Constants for File I/O
   DELIMITER         : constant Character := ';';
   MAX_BUFFER_LENGTH : constant Positive := 80;
   MAX_HEADER_TOKENS : constant Positive := 3;
   MAX_DATA_TOKENS   : constant Positive := 2;

end BPCONSTS;
