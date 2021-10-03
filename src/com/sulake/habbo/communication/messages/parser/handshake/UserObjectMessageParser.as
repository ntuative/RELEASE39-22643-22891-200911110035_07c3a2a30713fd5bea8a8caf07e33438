package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class UserObjectMessageParser implements IMessageParser
   {
       
      
      private var _id:int;
      
      private var var_828:String;
      
      private var var_2100:int;
      
      private var var_2097:String;
      
      private var var_2101:int;
      
      private var var_1202:String;
      
      private var var_2098:int;
      
      private var _name:String;
      
      private var var_678:int;
      
      private var var_2005:int;
      
      private var var_2099:String;
      
      public function UserObjectMessageParser()
      {
         super();
      }
      
      public function get directMail() : int
      {
         return this.var_2101;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get customData() : String
      {
         return this.var_2097;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get photoFilm() : int
      {
         return this.var_2100;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get respectTotal() : int
      {
         return this.var_2005;
      }
      
      public function get poolFigure() : String
      {
         return this.var_2099;
      }
      
      public function get figure() : String
      {
         return this.var_828;
      }
      
      public function get sex() : String
      {
         return this.var_1202;
      }
      
      public function get respectLeft() : int
      {
         return this.var_678;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._id = int(param1.readString());
         this._name = param1.readString();
         this.var_828 = param1.readString();
         this.var_1202 = param1.readString();
         this.var_2097 = param1.readString();
         this.var_2098 = param1.readInteger();
         this.var_2099 = param1.readString();
         this.var_2100 = param1.readInteger();
         this.var_2101 = param1.readInteger();
         this.var_2005 = param1.readInteger();
         this.var_678 = param1.readInteger();
         return true;
      }
      
      public function get tickets() : int
      {
         return this.var_2098;
      }
   }
}
