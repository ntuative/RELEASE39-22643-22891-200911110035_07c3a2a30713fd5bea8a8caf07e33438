package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class CantConnectMessageParser implements IMessageParser
   {
      
      public static const const_1440:int = 2;
      
      public static const const_303:int = 4;
      
      public static const const_1088:int = 1;
      
      public static const const_1146:int = 3;
       
      
      private var var_900:int = 0;
      
      private var var_736:String = "";
      
      public function CantConnectMessageParser()
      {
         super();
      }
      
      public function get reason() : int
      {
         return var_900;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_900 = param1.readInteger();
         if(var_900 == 3)
         {
            var_736 = param1.readString();
         }
         else
         {
            var_736 = "";
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_900 = 0;
         var_736 = "";
         return true;
      }
      
      public function get parameter() : String
      {
         return var_736;
      }
   }
}
