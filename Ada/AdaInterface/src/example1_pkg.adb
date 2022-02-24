package body Example1_Pkg is
  function Sum (Env : JNI_Env_Access; Class : J_Class; A, B : J_Int)
    return J_Int is
  begin
    return A + B;
  end Sum;
end Example1_Pkg;
