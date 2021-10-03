package com.sulake.habbo.help.cfh.data
{
   public class UserRegistryItem
   {
       
      
      private var var_603:String = "";
      
      private var _userName:String = "";
      
      private var _userId:int;
      
      public function UserRegistryItem(param1:int, param2:String, param3:String = "")
      {
         super();
         _userId = param1;
         _userName = param2;
         var_603 = param3;
      }
      
      public function set roomName(param1:String) : void
      {
         var_603 = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get roomName() : String
      {
         return var_603;
      }
   }
}
