package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IOutfit;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   import flash.display.BitmapData;
   
   public class Outfit implements IOutfit
   {
       
      
      private var _gender:String;
      
      private var var_828:String;
      
      private var _view:OutfitView;
      
      private var var_1305:IAvatarImage;
      
      private var _controller:HabboAvatarEditor;
      
      private var _image:BitmapData;
      
      public function Outfit(param1:HabboAvatarEditor, param2:String, param3:String)
      {
         super();
         _controller = param1;
         _view = new OutfitView(param1.windowManager,param1.assets,param2 != "");
         switch(param3)
         {
            case FigureData.const_71:
            case "m":
            case "M":
               param3 = "null";
               break;
            case FigureData.const_77:
            case "f":
            case "F":
               param3 = "null";
         }
         var_828 = param2;
         _gender = param3;
         update();
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get image() : BitmapData
      {
         if(_image == null)
         {
            return new BitmapData(33,56,false,0);
         }
         return _image;
      }
      
      public function get view() : OutfitView
      {
         return _view;
      }
      
      public function update() : void
      {
         var_1305 = _controller.avatarRenderManager.createAvatarImage(figure,AvatarScaleType.const_93);
         var_1305.setDirection(AvatarSetType.const_40,int(FigureData.const_839));
         _image = var_1305.getImage(AvatarSetType.const_40);
         _view.udpate(_image);
      }
      
      public function get figure() : String
      {
         return var_828;
      }
      
      public function dispose() : void
      {
         var_828 = null;
         _gender = null;
         _image = null;
      }
   }
}
