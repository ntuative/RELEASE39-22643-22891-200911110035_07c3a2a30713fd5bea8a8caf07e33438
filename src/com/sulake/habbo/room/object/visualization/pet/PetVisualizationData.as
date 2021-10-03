package com.sulake.habbo.room.object.visualization.pet
{
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class PetVisualizationData implements IRoomObjectVisualizationData
   {
       
      
      private var _avatarRenderer:IAvatarRenderManager = null;
      
      public function PetVisualizationData()
      {
         super();
      }
      
      public function initialize(param1:XML) : Boolean
      {
         return true;
      }
      
      public function getAvatar(param1:String, param2:String, param3:Number) : IAvatarImage
      {
         var _loc4_:* = null;
         if(param2 == "0")
         {
            param2 = "null";
         }
         else if(param2 == "1")
         {
            param2 = "null";
         }
         else if(param2 == "2")
         {
            param2 = "null";
         }
         else
         {
            param2 = "null";
         }
         if(_avatarRenderer != null)
         {
            _loc4_ = null;
            if(param3 > 48)
            {
               _loc4_ = _avatarRenderer.createPetImage(param1,param2,AvatarScaleType.const_66);
            }
            else
            {
               _loc4_ = _avatarRenderer.createPetImage(param1,param2,AvatarScaleType.const_93);
            }
            return _loc4_;
         }
         return null;
      }
      
      public function getLayerCount(param1:String) : Number
      {
         return 0;
      }
      
      public function set avatarRenderer(param1:IAvatarRenderManager) : void
      {
         _avatarRenderer = param1;
      }
      
      public function get avatarRenderer() : IAvatarRenderManager
      {
         return _avatarRenderer;
      }
      
      public function dispose() : void
      {
         _avatarRenderer = null;
      }
   }
}
