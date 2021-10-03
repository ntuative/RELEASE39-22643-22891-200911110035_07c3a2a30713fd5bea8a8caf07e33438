package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   public class RoomSettingsData
   {
      
      public static const const_346:int = 0;
      
      public static const const_113:int = 2;
      
      public static const const_150:int = 1;
      
      public static const const_685:Array = ["open","closed","password"];
       
      
      private var var_1694:int;
      
      private var var_1691:int;
      
      private var var_1692:Array;
      
      private var var_1011:String;
      
      private var var_1698:Boolean;
      
      private var var_1693:int;
      
      private var var_1695:int;
      
      private var var_1165:int;
      
      private var var_1696:Boolean;
      
      private var _roomId:int;
      
      private var var_1697:Boolean;
      
      private var _name:String;
      
      private var var_546:Array;
      
      public function RoomSettingsData()
      {
         super();
      }
      
      public function get maximumVisitors() : int
      {
         return var_1693;
      }
      
      public function set maximumVisitors(param1:int) : void
      {
         var_1693 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get tags() : Array
      {
         return var_546;
      }
      
      public function get allowTrading() : Boolean
      {
         return var_1697;
      }
      
      public function set controllerCount(param1:int) : void
      {
         var_1694 = param1;
      }
      
      public function set roomId(param1:int) : void
      {
         _roomId = param1;
      }
      
      public function set controllers(param1:Array) : void
      {
         var_1692 = param1;
      }
      
      public function set allowTrading(param1:Boolean) : void
      {
         var_1697 = param1;
      }
      
      public function set tags(param1:Array) : void
      {
         var_546 = param1;
      }
      
      public function get maximumVisitorsLimit() : int
      {
         return var_1691;
      }
      
      public function get categoryId() : int
      {
         return var_1165;
      }
      
      public function set showOwnerName(param1:Boolean) : void
      {
         var_1696 = param1;
      }
      
      public function set allowFurniMoving(param1:Boolean) : void
      {
         var_1698 = param1;
      }
      
      public function get controllerCount() : int
      {
         return var_1694;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get controllers() : Array
      {
         return var_1692;
      }
      
      public function get showOwnerName() : Boolean
      {
         return var_1696;
      }
      
      public function get allowFurniMoving() : Boolean
      {
         return var_1698;
      }
      
      public function set doorMode(param1:int) : void
      {
         var_1695 = param1;
      }
      
      public function set maximumVisitorsLimit(param1:int) : void
      {
         var_1691 = param1;
      }
      
      public function get doorMode() : int
      {
         return var_1695;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_1165 = param1;
      }
      
      public function set description(param1:String) : void
      {
         var_1011 = param1;
      }
      
      public function get description() : String
      {
         return var_1011;
      }
   }
}
