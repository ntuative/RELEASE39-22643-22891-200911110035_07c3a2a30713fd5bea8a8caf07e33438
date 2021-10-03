package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
   
   public class NewBuddyRequestMessageParser implements IMessageParser
   {
       
      
      private var var_2089:FriendRequestData;
      
      public function NewBuddyRequestMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2089 = new FriendRequestData(param1);
         return true;
      }
      
      public function get req() : FriendRequestData
      {
         return this.var_2089;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
