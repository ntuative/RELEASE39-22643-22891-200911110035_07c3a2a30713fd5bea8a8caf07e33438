package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class OfficialRoomEntryData implements IDisposable
   {
      
      public static const const_896:int = 4;
      
      public static const TYPE_PUBLIC_SPACE:int = 3;
      
      public static const const_496:int = 2;
      
      public static const const_853:int = 1;
       
      
      private var var_1957:String;
      
      private var _disposed:Boolean;
      
      private var var_1531:int;
      
      private var var_1955:Boolean;
      
      private var var_675:String;
      
      private var var_792:PublicRoomData;
      
      private var _index:int;
      
      private var var_1953:String;
      
      private var _type:int;
      
      private var var_1689:String;
      
      private var var_793:GuestRoomData;
      
      private var var_1954:String;
      
      private var var_1956:int;
      
      public function OfficialRoomEntryData(param1:int, param2:IMessageDataWrapper)
      {
         super();
         _index = param1;
         var_1957 = param2.readString();
         var_1954 = param2.readString();
         var_1955 = param2.readInteger() == 1;
         var_1953 = param2.readString();
         var_675 = param2.readString();
         var_1531 = param2.readInteger();
         _type = param2.readInteger();
         if(_type == const_853)
         {
            var_1689 = param2.readString();
         }
         else if(_type == TYPE_PUBLIC_SPACE)
         {
            var_792 = new PublicRoomData(param2);
         }
         else if(_type == const_496)
         {
            var_793 = new GuestRoomData(param2);
         }
         else if(_type == const_896)
         {
            var_1956 = param2.readInteger();
         }
      }
      
      public function get tag() : String
      {
         return var_1689;
      }
      
      public function get userCount() : int
      {
         return var_1531;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get showDetails() : Boolean
      {
         return var_1955;
      }
      
      public function get picText() : String
      {
         return var_1953;
      }
      
      public function get maxUsers() : int
      {
         if(this.type == const_853)
         {
            return 0;
         }
         if(this.type == const_496)
         {
            return this.var_793.maxUserCount;
         }
         if(this.type == TYPE_PUBLIC_SPACE)
         {
            return this.var_792.maxUsers;
         }
         return 0;
      }
      
      public function get popupDesc() : String
      {
         return var_1954;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(this.var_793 != null)
         {
            this.var_793.dispose();
            this.var_793 = null;
         }
         if(this.var_792 != null)
         {
            this.var_792.dispose();
            this.var_792 = null;
         }
      }
      
      public function get popupCaption() : String
      {
         return var_1957;
      }
      
      public function get guestRoomData() : GuestRoomData
      {
         return var_793;
      }
      
      public function get picRef() : String
      {
         return var_675;
      }
      
      public function get flatCategoryId() : int
      {
         return var_1956;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get publicRoomData() : PublicRoomData
      {
         return var_792;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}
