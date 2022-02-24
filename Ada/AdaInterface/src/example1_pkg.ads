with Interfaces.Java.JNI; use Interfaces.Java.JNI;
package Example1_Pkg is
  function Sum (Env : JNI_Env_Access; Class : J_Class; A, B : J_Int)
    return J_Int;
  pragma Export (C, Sum, "Java_Example1_sum__II");
end Example1_Pkg;
