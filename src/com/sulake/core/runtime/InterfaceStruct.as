package com.sulake.core.runtime
{
   import flash.utils.getQualifiedClassName;
   
   final class InterfaceStruct
   {
       
      
      private var var_965:IID;
      
      private var var_389:uint;
      
      private var var_1196:IUnknown;
      
      private var var_1197:String;
      
      function InterfaceStruct(param1:IID, param2:IUnknown)
      {
         super();
         var_965 = param1;
         var_1197 = getQualifiedClassName(var_965);
         var_1196 = param2;
         var_389 = 0;
      }
      
      public function get iid() : IID
      {
         return var_965;
      }
      
      public function get references() : uint
      {
         return var_389;
      }
      
      public function release() : uint
      {
         return references > 0 ? uint(--var_389) : uint(0);
      }
      
      public function get unknown() : IUnknown
      {
         return var_1196;
      }
      
      public function get iis() : String
      {
         return var_1197;
      }
      
      public function reserve() : uint
      {
         return ++var_389;
      }
      
      public function dispose() : void
      {
         var_965 = null;
         var_1197 = null;
         var_1196 = null;
         var_389 = 0;
      }
   }
}
