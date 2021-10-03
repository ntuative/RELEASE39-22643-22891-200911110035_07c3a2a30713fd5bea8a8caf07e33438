package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
   
   public class ModeratorInitMessageParser implements IMessageParser
   {
       
      
      private var _roomMessageTemplates:Array;
      
      private var var_1761:Boolean;
      
      private var var_1348:Array;
      
      private var var_1763:Boolean;
      
      private var var_1765:Boolean;
      
      private var var_1762:Boolean;
      
      private var var_152:Array;
      
      private var var_1760:Boolean;
      
      private var var_1759:Boolean;
      
      private var var_1347:Array;
      
      private var var_1766:Boolean;
      
      private var var_1764:Boolean;
      
      public function ModeratorInitMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get banPermission() : Boolean
      {
         return var_1764;
      }
      
      public function get roomKickPermission() : Boolean
      {
         return var_1761;
      }
      
      public function get alertPermission() : Boolean
      {
         return var_1763;
      }
      
      public function get cfhPermission() : Boolean
      {
         return var_1760;
      }
      
      public function get roomMessageTemplates() : Array
      {
         return _roomMessageTemplates;
      }
      
      public function get roomAlertPermission() : Boolean
      {
         return var_1759;
      }
      
      public function get messageTemplates() : Array
      {
         return var_1348;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:IssueInfoMessageParser = new IssueInfoMessageParser();
         var_152 = [];
         var_1348 = [];
         _roomMessageTemplates = [];
         var_1347 = [];
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(!_loc2_.parse(param1))
            {
               return false;
            }
            var_152.push(_loc2_.issueData);
            _loc4_++;
         }
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var_1348.push(param1.readString());
            _loc4_++;
         }
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var_1347.push(new OffenceCategoryData(param1));
            _loc4_++;
         }
         var_1760 = param1.readBoolean();
         var_1762 = param1.readBoolean();
         var_1763 = param1.readBoolean();
         var_1765 = param1.readBoolean();
         var_1764 = param1.readBoolean();
         var_1759 = param1.readBoolean();
         var_1761 = param1.readBoolean();
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _roomMessageTemplates.push(param1.readString());
            _loc4_++;
         }
         var_1766 = param1.readBoolean();
         return true;
      }
      
      public function get kickPermission() : Boolean
      {
         return var_1765;
      }
      
      public function get offenceCategories() : Array
      {
         return var_1347;
      }
      
      public function get issues() : Array
      {
         return var_152;
      }
      
      public function get bobbaFilterPermission() : Boolean
      {
         return var_1766;
      }
      
      public function get chatlogsPermission() : Boolean
      {
         return var_1762;
      }
   }
}
