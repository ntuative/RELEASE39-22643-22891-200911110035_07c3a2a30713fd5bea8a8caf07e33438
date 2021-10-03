package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ScrSendUserInfoMessageParser implements IMessageParser
   {
       
      
      private var var_1823:int;
      
      private var var_1058:String;
      
      private var var_1821:int;
      
      private var var_1825:int;
      
      private var var_1824:int;
      
      private var var_1822:Boolean;
      
      public function ScrSendUserInfoMessageParser()
      {
         super();
      }
      
      public function get productName() : String
      {
         return var_1058;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get hasEverBeenMember() : Boolean
      {
         return var_1822;
      }
      
      public function get responseType() : int
      {
         return var_1825;
      }
      
      public function get daysToPeriodEnd() : int
      {
         return var_1821;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1058 = param1.readString();
         var_1821 = param1.readInteger();
         var_1823 = param1.readInteger();
         var_1824 = param1.readInteger();
         var_1825 = param1.readInteger();
         var_1822 = param1.readBoolean();
         return true;
      }
      
      public function get memberPeriods() : int
      {
         return var_1823;
      }
      
      public function get periodsSubscribedAhead() : int
      {
         return var_1824;
      }
   }
}
