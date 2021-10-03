package com.sulake.habbo.communication.messages.incoming.navigator
{
   public class RoomThumbnailObjectData
   {
       
      
      private var var_1390:int;
      
      private var var_1389:int;
      
      public function RoomThumbnailObjectData()
      {
         super();
      }
      
      public function get pos() : int
      {
         return var_1390;
      }
      
      public function set pos(param1:int) : void
      {
         this.var_1390 = param1;
      }
      
      public function getCopy() : RoomThumbnailObjectData
      {
         var _loc1_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
         _loc1_.var_1390 = this.var_1390;
         _loc1_.var_1389 = this.var_1389;
         return _loc1_;
      }
      
      public function set imgId(param1:int) : void
      {
         this.var_1389 = param1;
      }
      
      public function get imgId() : int
      {
         return var_1389;
      }
   }
}
