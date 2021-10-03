package com.sulake.habbo.messenger.domain
{
   public class Message
   {
      
      public static const const_489:int = 2;
      
      public static const const_775:int = 6;
      
      public static const const_568:int = 1;
      
      public static const const_477:int = 3;
      
      public static const const_766:int = 4;
      
      public static const const_601:int = 5;
       
      
      private var var_1678:String;
      
      private var var_937:int;
      
      private var var_1574:String;
      
      private var _type:int;
      
      public function Message(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         _type = param1;
         var_937 = param2;
         var_1574 = param3;
         var_1678 = param4;
      }
      
      public function get time() : String
      {
         return var_1678;
      }
      
      public function get senderId() : int
      {
         return var_937;
      }
      
      public function get messageText() : String
      {
         return var_1574;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}
