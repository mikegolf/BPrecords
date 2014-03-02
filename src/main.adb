-------------------------------------------------------------------------------
-- File Name   : main.adb
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Contains the main procedure to be called on application
--               startup. Offers a simple menu to the user to be able to
--               select between reading a record or adding a new one.
--
-- Dependency  : Package CONSOLE must be defined.
-------------------------------------------------------------------------------

With Ada.Task_Identification;  use Ada.Task_Identification;
With Ada.Integer_Text_IO; Use Ada.Integer_Text_IO;
With Ada.Text_IO; Use Ada.Text_IO;

With CONSOLE;

procedure Main is

   Choice : Integer;

begin

   Put_Line("Task selection :" & ASCII.LF &
            "  1. View record" & ASCII.LF &
            "  2. Add record" & ASCII.LF &
            "  3. Quit");

   Get(Choice);
   Skip_Line;

   case Choice is
      when 1 =>
         CONSOLE.View_record;
      when 2 =>
         CONSOLE.Add_record;
      when 3 =>
         Abort_Task (Current_Task);
      when others =>
         Put_Line("Incorrect choice");
   end case;

end Main;
