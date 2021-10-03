package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.getTimer;
   
   public class IssueInfoMessageParser implements IMessageParser
   {
       
      
      private var var_62:IssueMessageData;
      
      public function IssueInfoMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_62 = new IssueMessageData();
         var_62.issueId = param1.readInteger();
         var_62.state = param1.readInteger();
         var_62.categoryId = param1.readInteger();
         var_62.reportedCategoryId = param1.readInteger();
         var_62.timeStamp = getTimer() - param1.readInteger();
         var_62.priority = param1.readInteger();
         var_62.reporterUserId = param1.readInteger();
         var_62.reporterUserName = param1.readString();
         var_62.reportedUserId = param1.readInteger();
         var_62.reportedUserName = param1.readString();
         var_62.pickerUserId = param1.readInteger();
         var_62.pickerUserName = param1.readString();
         var_62.message = param1.readString();
         var_62.method_8 = param1.readInteger();
         var_62.roomName = param1.readString();
         var_62.roomType = param1.readInteger();
         if(false)
         {
            var_62.roomResources = param1.readString();
            var_62.unitPort = param1.readInteger();
            var_62.worldId = param1.readInteger();
         }
         if(false)
         {
            var_62.flatType = param1.readString();
            var_62.flatId = param1.readInteger();
            var_62.flatOwnerName = param1.readString();
         }
         return true;
      }
      
      public function get issueData() : IssueMessageData
      {
         return var_62;
      }
      
      public function flush() : Boolean
      {
         var_62 = null;
         return true;
      }
   }
}
