package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class AcceptBuddyFailureData
   {
       
      
      private var var_983:int;
      
      private var var_936:String;
      
      public function AcceptBuddyFailureData(param1:IMessageDataWrapper)
      {
         super();
         this.var_936 = param1.readString();
         this.var_983 = param1.readInteger();
      }
      
      public function get senderName() : String
      {
         return this.var_936;
      }
      
      public function get errorCode() : int
      {
         return this.var_983;
      }
   }
}
