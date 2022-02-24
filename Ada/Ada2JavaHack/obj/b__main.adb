pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E071 : Short_Integer; pragma Import (Ada, E071, "system__os_lib_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exception_table_E");
   E040 : Short_Integer; pragma Import (Ada, E040, "ada__containers_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "ada__io_exceptions_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__strings_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__strings__maps_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__strings__maps__constants_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "interfaces__c_E");
   E028 : Short_Integer; pragma Import (Ada, E028, "system__exceptions_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "system__object_reader_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "system__dwarf_lines_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__soft_links__initialize_E");
   E039 : Short_Integer; pragma Import (Ada, E039, "system__traceback__symbolic_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "ada__strings__utf_encoding_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "ada__tags_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "ada__strings__text_buffers_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "gnat_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "interfaces__c__strings_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "ada__streams_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "system__file_control_block_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "system__finalization_root_E");
   E154 : Short_Integer; pragma Import (Ada, E154, "ada__finalization_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "system__file_io_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "system__storage_pools_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "system__finalization_masters_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "system__storage_pools__subpools_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "ada__strings__unbounded_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "system__task_info_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__calendar__delays_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__real_time_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "ada__text_io_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "system__pool_global_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "gnat__sockets_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "gnat__sockets__poll_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "gnat__sockets__thin_common_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "gnat__sockets__thin_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "system__tasking__initialization_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "system__tasking__protected_objects_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "system__tasking__protected_objects__entries_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "system__tasking__queuing_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "system__tasking__stages_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E221 := E221 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gnat__sockets__finalize_body");
      begin
         E160 := E160 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "gnat__sockets__finalize_spec");
      begin
         F3;
      end;
      E176 := E176 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__pool_global__finalize_spec");
      begin
         F4;
      end;
      E149 := E149 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__text_io__finalize_spec");
      begin
         F5;
      end;
      E186 := E186 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ada__strings__unbounded__finalize_spec");
      begin
         F6;
      end;
      E180 := E180 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__storage_pools__subpools__finalize_spec");
      begin
         F7;
      end;
      E172 := E172 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__finalization_masters__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__file_io__finalize_body");
      begin
         E153 := E153 - 1;
         F9;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, False, False, True, False, False, True, True, 
           False, True, True, False, True, True, True, True, 
           False, False, False, False, False, True, False, False, 
           True, False, True, False, False, True, False, True, 
           False, True, False, False, False, True, False, True, 
           False, False, False, True, False, False, True, False, 
           True, True, True, False, False, True, False, True, 
           True, True, False, True, True, False, True, True, 
           True, True, False, False, False, False, False, False, 
           False, False, False, False, True, True, False, False, 
           False),
         Count => (0, 0, 0, 0, 0, 2, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E027 := E027 + 1;
      Ada.Containers'Elab_Spec;
      E040 := E040 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E067 := E067 + 1;
      Ada.Strings'Elab_Spec;
      E052 := E052 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E054 := E054 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E058 := E058 + 1;
      Interfaces.C'Elab_Spec;
      E077 := E077 + 1;
      System.Exceptions'Elab_Spec;
      E028 := E028 + 1;
      System.Object_Reader'Elab_Spec;
      E079 := E079 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E047 := E047 + 1;
      System.Os_Lib'Elab_Body;
      E071 := E071 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E023 := E023 + 1;
      E015 := E015 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E039 := E039 + 1;
      E010 := E010 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E133 := E133 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E139 := E139 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      Ada.Strings.Text_Buffers'Elab_Body;
      E131 := E131 + 1;
      Gnat'Elab_Spec;
      E158 := E158 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E109 := E109 + 1;
      Ada.Streams'Elab_Spec;
      E129 := E129 + 1;
      System.File_Control_Block'Elab_Spec;
      E157 := E157 + 1;
      System.Finalization_Root'Elab_Spec;
      System.Finalization_Root'Elab_Body;
      E156 := E156 + 1;
      Ada.Finalization'Elab_Spec;
      E154 := E154 + 1;
      System.File_Io'Elab_Body;
      E153 := E153 + 1;
      System.Storage_Pools'Elab_Spec;
      E174 := E174 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E172 := E172 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Body;
      E180 := E180 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      Ada.Strings.Unbounded'Elab_Body;
      E186 := E186 + 1;
      System.Task_Info'Elab_Spec;
      E119 := E119 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E006 := E006 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E103 := E103 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E149 := E149 + 1;
      System.Pool_Global'Elab_Spec;
      System.Pool_Global'Elab_Body;
      E176 := E176 + 1;
      Gnat.Sockets'Elab_Spec;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E167 := E167 + 1;
      Gnat.Sockets.Thin'Elab_Body;
      E165 := E165 + 1;
      Gnat.Sockets'Elab_Body;
      E160 := E160 + 1;
      E163 := E163 + 1;
      System.Tasking.Initialization'Elab_Body;
      E211 := E211 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E219 := E219 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E221 := E221 + 1;
      System.Tasking.Queuing'Elab_Body;
      E225 := E225 + 1;
      System.Tasking.Stages'Elab_Body;
      E229 := E229 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\randy\Documents\Ada2JavaHack\obj\main.o
   --   -LC:\Users\randy\Documents\Ada2JavaHack\obj\
   --   -LC:\Users\randy\Documents\Ada2JavaHack\obj\
   --   -LC:/gnat/2021/lib/gcc/x86_64-w64-mingw32/10.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lws2_32
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
