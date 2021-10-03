package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.logic.MovingObjectLogic;
   
   public class FurnitureShadowLogic extends MovingObjectLogic
   {
       
      
      public function FurnitureShadowLogic()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         object.getModelController().setNumber(RoomObjectVariableEnum.const_158,1);
      }
   }
}
