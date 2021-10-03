package com.sulake.habbo.communication.messages.parser.moderation
{
   import flash.utils.getTimer;
   
   public class IssueMessageData
   {
      
      public static const const_126:int = 1;
      
      public static const const_1087:int = 3;
      
      public static const const_389:int = 2;
       
      
      private var var_1780:int;
      
      private var var_1652:int;
      
      private var var_1782:int;
      
      private var var_1654:int;
      
      private var _state:int;
      
      private var var_372:int;
      
      private var var_996:int;
      
      private var var_1650:int;
      
      private var var_966:int;
      
      private var _roomResources:String;
      
      private var var_1784:int;
      
      private var var_1781:int;
      
      private var var_1778:String;
      
      private var var_1649:String;
      
      private var var_1785:int = 0;
      
      private var var_1204:String;
      
      private var _message:String;
      
      private var var_1783:int;
      
      private var var_1786:String;
      
      private var var_1165:int;
      
      private var var_603:String;
      
      private var var_1779:String;
      
      private var var_1354:int;
      
      public function IssueMessageData()
      {
         super();
      }
      
      public function set reportedUserId(param1:int) : void
      {
         var_966 = param1;
      }
      
      public function set temporalPriority(param1:int) : void
      {
         var_1785 = param1;
      }
      
      public function get reporterUserId() : int
      {
         return var_1781;
      }
      
      public function set roomName(param1:String) : void
      {
         var_603 = param1;
      }
      
      public function set method_8(param1:int) : void
      {
         var_1784 = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get roomResources() : String
      {
         return _roomResources;
      }
      
      public function set roomResources(param1:String) : void
      {
         _roomResources = param1;
      }
      
      public function get roomName() : String
      {
         return var_603;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function set worldId(param1:int) : void
      {
         var_1654 = param1;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get unitPort() : int
      {
         return var_1652;
      }
      
      public function get priority() : int
      {
         return var_1780 + var_1785;
      }
      
      public function set issueId(param1:int) : void
      {
         var_1650 = param1;
      }
      
      public function get pickerUserName() : String
      {
         return var_1649;
      }
      
      public function getOpenTime() : String
      {
         var _loc1_:int = (getTimer() - var_1354) / 1000;
         var _loc2_:int = _loc1_ % 60;
         var _loc3_:int = _loc1_ / 60;
         var _loc4_:int = _loc3_ % 60;
         var _loc5_:int = _loc3_ / 60;
         var _loc6_:String = _loc2_ < 10 ? "0" + _loc2_ : "" + _loc2_;
         var _loc7_:String = _loc4_ < 10 ? "0" + _loc4_ : "" + _loc4_;
         var _loc8_:String = _loc5_ < 10 ? "0" + _loc5_ : "" + _loc5_;
         return _loc8_ + ":" + _loc7_ + ":" + _loc6_;
      }
      
      public function get categoryId() : int
      {
         return var_1165;
      }
      
      public function set reporterUserId(param1:int) : void
      {
         var_1781 = param1;
      }
      
      public function get roomType() : int
      {
         return var_996;
      }
      
      public function set flatType(param1:String) : void
      {
         var_1778 = param1;
      }
      
      public function get method_8() : int
      {
         return var_1784;
      }
      
      public function set message(param1:String) : void
      {
         _message = param1;
      }
      
      public function get worldId() : int
      {
         return var_1654;
      }
      
      public function set flatOwnerName(param1:String) : void
      {
         var_1779 = param1;
      }
      
      public function set reportedUserName(param1:String) : void
      {
         var_1204 = param1;
      }
      
      public function get issueId() : int
      {
         return var_1650;
      }
      
      public function set priority(param1:int) : void
      {
         var_1780 = param1;
      }
      
      public function set unitPort(param1:int) : void
      {
         var_1652 = param1;
      }
      
      public function get flatType() : String
      {
         return var_1778;
      }
      
      public function set reportedCategoryId(param1:int) : void
      {
         var_1782 = param1;
      }
      
      public function set pickerUserName(param1:String) : void
      {
         var_1649 = param1;
      }
      
      public function set pickerUserId(param1:int) : void
      {
         var_1783 = param1;
      }
      
      public function get reportedUserName() : String
      {
         return var_1204;
      }
      
      public function set roomType(param1:int) : void
      {
         var_996 = param1;
      }
      
      public function get reportedCategoryId() : int
      {
         return var_1782;
      }
      
      public function set flatId(param1:int) : void
      {
         var_372 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_1165 = param1;
      }
      
      public function set timeStamp(param1:int) : void
      {
         var_1354 = param1;
      }
      
      public function get pickerUserId() : int
      {
         return var_1783;
      }
      
      public function set reporterUserName(param1:String) : void
      {
         var_1786 = param1;
      }
      
      public function get timeStamp() : int
      {
         return var_1354;
      }
      
      public function get reportedUserId() : int
      {
         return var_966;
      }
      
      public function get flatId() : int
      {
         return var_372;
      }
      
      public function get flatOwnerName() : String
      {
         return var_1779;
      }
      
      public function get reporterUserName() : String
      {
         return var_1786;
      }
   }
}
