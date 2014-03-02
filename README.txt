
Overview:

The application stores blood pressure data of patients in a text based data store. It lets the user interact using the command line to add recordings for a new patient or fetch already stored recordings for a given patient.

Internally it creates records after reading in the values input by the user and upon fetching values from the data store. These records can possibly be serialized in other forms and transmitted over the network.
I chose text based data store for learning purposes only and the calls to the procedures can be easily replaced by calls to RDBMS queries or IPC calls or any other persistent storage mechanism.

I could only manage Create and Read semantics so far. Moreover Update and Delete operations would probably not be practical to implement using a text based data storage.

Data storage:

Data is stored in plain text in a delimiter separated format.

- The records are referenced by a Patient Id, with information on Patient name, number of BP recordings.
- The blood pressure records are stored in form of pairs of systolic and diastolic readings.

Details of data storage format are in the attached file Text_record_format.txt as part of the attached zip. A sample file is also there : BP_Data.txt containing some records.

Improvement/further work:

- Error and exception handling. Most of the input validations rely on Ada language features, but are not enough by any means. It should at least check for the file being present.
- Making the file read and write functions capable of concurrent execution, so that there could be multiple consoles accessing the data store at the same time.

Compiler / Platform:

I used the Gnat Programming Studio on Windows 7. I found the IDE to be good in certain aspects, but the interface with gdb wasn't as usable as it could be using in a simple terminal. I couldn't get the ada compiler running in my Linux environment. But it could also have been because of the sad state of gnat packages on gentoo and dependency issues with Gtk.