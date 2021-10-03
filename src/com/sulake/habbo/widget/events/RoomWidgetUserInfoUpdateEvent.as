package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_197:String = "RWUIUE_PEER";
      
      public static const const_257:String = "RWUIUE_OWN_USER";
      
      public static const TRADE_REASON_NO_OWN_RIGHT:int = 1;
      
      public static const BOT:String = "RWUIUE_BOT";
      
      public static const const_1141:String = "BOT";
      
      public static const const_873:int = 2;
      
      public static const const_1277:int = 0;
      
      public static const const_796:int = 3;
       
      
      private var var_1163:String = "";
      
      private var var_1522:Boolean = false;
      
      private var var_1458:int = 0;
      
      private var var_1525:int = 0;
      
      private var var_1516:Boolean = false;
      
      private var var_1526:Boolean = false;
      
      private var var_678:int = 0;
      
      private var var_1518:Boolean = true;
      
      private var var_844:int = 0;
      
      private var var_1519:Boolean = false;
      
      private var var_1008:Boolean = false;
      
      private var var_1520:Boolean = false;
      
      private var var_1527:Boolean = false;
      
      private var var_1521:int = 0;
      
      private var _image:BitmapData = null;
      
      private var var_164:Array;
      
      private var var_1010:Boolean = false;
      
      private var _name:String = "";
      
      private var var_1455:int = 0;
      
      private var var_1523:Boolean = false;
      
      private var var_1517:int = 0;
      
      private var var_1524:String = "";
      
      public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         var_164 = [];
         super(param1,param2,param3);
      }
      
      public function get userRoomId() : int
      {
         return var_1525;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_1525 = param1;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return var_1522;
      }
      
      public function get canBeKicked() : Boolean
      {
         return var_1518;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         var_1518 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_1526 = param1;
      }
      
      public function get motto() : String
      {
         return var_1163;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_1519 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return var_1008;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set motto(param1:String) : void
      {
         var_1163 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_1523;
      }
      
      public function get groupBadgeId() : String
      {
         return var_1524;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         var_1008 = param1;
      }
      
      public function get hasFlatControl() : Boolean
      {
         return var_1520;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_1521 = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return var_1010;
      }
      
      public function get badges() : Array
      {
         return var_164;
      }
      
      public function get amIController() : Boolean
      {
         return var_1516;
      }
      
      public function set amIController(param1:Boolean) : void
      {
         var_1516 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_1523 = param1;
      }
      
      public function set image(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         var_1517 = param1;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var_1524 = param1;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_1526;
      }
      
      public function get isIgnored() : Boolean
      {
         return var_1519;
      }
      
      public function get carryItem() : int
      {
         return var_1521;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         var_1010 = param1;
      }
      
      public function get canTradeReason() : int
      {
         return var_1517;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_678 = param1;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function set webID(param1:int) : void
      {
         var_1455 = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         var_164 = param1;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         var_1527 = param1;
      }
      
      public function set hasFlatControl(param1:Boolean) : void
      {
         var_1520 = param1;
      }
      
      public function get respectLeft() : int
      {
         return var_678;
      }
      
      public function get webID() : int
      {
         return var_1455;
      }
      
      public function set groupId(param1:int) : void
      {
         var_844 = param1;
      }
      
      public function get xp() : int
      {
         return var_1458;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         var_1522 = param1;
      }
      
      public function get groupId() : int
      {
         return var_844;
      }
      
      public function get canTrade() : Boolean
      {
         return var_1527;
      }
      
      public function set xp(param1:int) : void
      {
         var_1458 = param1;
      }
   }
}
