-------------------------------------------------------------------------------
-- File Name   : console.ads
-- Author      : Mayank Gupta
-- Created     : 28/02/2014
--
-- Description : Contains the package CONSOLE which provides the application
--               procedures which enable and interact with the user who can
--               input their choices and data via standard input and see the
--               fetched records listed on standard output.
--
-- Dependency  : Packages BPCONSTS, BPUTILS, TEXTDB must be defined.
-------------------------------------------------------------------------------

package CONSOLE is

   procedure View_record;
   procedure Add_record;

end CONSOLE;
