package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class ItemMessageData
   {
       
      
      private var var_87:Number = 0;
      
      private var _data:String = "";
      
      private var var_2136:int = 0;
      
      private var _state:int = 0;
      
      private var _type:int = 0;
      
      private var _y:Number = 0;
      
      private var var_1923:Boolean = false;
      
      private var var_2135:String = "";
      
      private var _id:int = 0;
      
      private var var_185:Boolean = false;
      
      private var var_207:String = "";
      
      private var var_1922:int = 0;
      
      private var var_1921:int = 0;
      
      private var var_1919:int = 0;
      
      private var var_1920:int = 0;
      
      public function ItemMessageData(param1:int, param2:int, param3:Boolean)
      {
         super();
         _id = param1;
         _type = param2;
         var_1923 = param3;
      }
      
      public function set y(param1:Number) : void
      {
         if(!var_185)
         {
            _y = param1;
         }
      }
      
      public function get isOldFormat() : Boolean
      {
         return var_1923;
      }
      
      public function set type(param1:int) : void
      {
         if(!var_185)
         {
            _type = param1;
         }
      }
      
      public function get dir() : String
      {
         return var_207;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set localX(param1:Number) : void
      {
         if(!var_185)
         {
            var_1919 = param1;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set wallX(param1:Number) : void
      {
         if(!var_185)
         {
            var_1922 = param1;
         }
      }
      
      public function set wallY(param1:Number) : void
      {
         if(!var_185)
         {
            var_1921 = param1;
         }
      }
      
      public function set dir(param1:String) : void
      {
         if(!var_185)
         {
            var_207 = param1;
         }
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function set localY(param1:Number) : void
      {
         if(!var_185)
         {
            var_1920 = param1;
         }
      }
      
      public function set state(param1:int) : void
      {
         if(!var_185)
         {
            _state = param1;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get localX() : Number
      {
         return var_1919;
      }
      
      public function set data(param1:String) : void
      {
         if(!var_185)
         {
            _data = param1;
         }
      }
      
      public function get wallX() : Number
      {
         return var_1922;
      }
      
      public function get wallY() : Number
      {
         return var_1921;
      }
      
      public function get localY() : Number
      {
         return var_1920;
      }
      
      public function setReadOnly() : void
      {
         var_185 = true;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get z() : Number
      {
         return var_87;
      }
      
      public function set z(param1:Number) : void
      {
         if(!var_185)
         {
            var_87 = param1;
         }
      }
   }
}
