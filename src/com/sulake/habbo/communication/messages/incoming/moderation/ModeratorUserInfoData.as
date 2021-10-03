package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ModeratorUserInfoData
   {
       
      
      private var var_1805:int;
      
      private var var_1806:int;
      
      private var var_1808:int;
      
      private var _userName:String;
      
      private var var_1803:int;
      
      private var var_1807:int;
      
      private var var_1804:int;
      
      private var _userId:int;
      
      private var var_795:Boolean;
      
      public function ModeratorUserInfoData(param1:IMessageDataWrapper)
      {
         super();
         _userId = param1.readInteger();
         _userName = param1.readString();
         var_1807 = param1.readInteger();
         var_1803 = param1.readInteger();
         var_795 = param1.readBoolean();
         var_1808 = param1.readInteger();
         var_1806 = param1.readInteger();
         var_1805 = param1.readInteger();
         var_1804 = param1.readInteger();
      }
      
      public function get banCount() : int
      {
         return var_1804;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get online() : Boolean
      {
         return var_795;
      }
      
      public function get minutesSinceLastLogin() : int
      {
         return var_1803;
      }
      
      public function get abusiveCfhCount() : int
      {
         return var_1806;
      }
      
      public function get cautionCount() : int
      {
         return var_1805;
      }
      
      public function get cfhCount() : int
      {
         return var_1808;
      }
      
      public function get minutesSinceRegistration() : int
      {
         return var_1807;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}
