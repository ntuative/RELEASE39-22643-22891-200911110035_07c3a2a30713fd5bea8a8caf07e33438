package com.sulake.habbo.avatar.head
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.AvatarEditorGridItem;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   import flash.utils.Dictionary;
   
   public class HeadModel implements IAvatarEditorCategoryModel
   {
       
      
      private var var_306:Dictionary;
      
      private var _view:HeadView;
      
      private var _controller:HabboAvatarEditor;
      
      private var var_676:Boolean = false;
      
      private var _gender:String;
      
      public function HeadModel(param1:HabboAvatarEditor, param2:String = "")
      {
         super();
         _controller = param1;
         _gender = param2;
      }
      
      public function toggleItemSelection(param1:String, param2:int) : void
      {
         var _loc3_:CategoryData = var_306[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:AvatarEditorGridItem = _loc3_.select(param2);
         _controller.figureData.savePartData(param1,_loc4_.id,_loc3_.currentColourId,true);
      }
      
      public function closingEditorView() : void
      {
         reset();
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!var_676)
         {
            init();
         }
         return _view.getWindowContainer();
      }
      
      public function reset() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_306)
         {
            _loc1_.dispose();
         }
         var_306 = null;
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
         var_676 = false;
      }
      
      private function init() : void
      {
         var_306 = new Dictionary();
         _view = new HeadView(this,method_1.windowManager,method_1.assets);
         updateView();
         var_676 = true;
      }
      
      public function categorySwitch(param1:String) : void
      {
         switch(param1)
         {
            case FigureData.const_111:
            case FigureData.const_135:
            case FigureData.const_133:
            case FigureData.const_143:
            case FigureData.const_137:
               initCategory(param1);
               break;
            default:
               Logger.log("Unknown category...");
         }
      }
      
      public function get method_1() : HabboAvatarEditor
      {
         return _controller;
      }
      
      public function updateView() : void
      {
         updateCategoryData(FigureData.const_111);
         updateCategoryData(FigureData.const_135);
         updateCategoryData(FigureData.const_133);
         updateCategoryData(FigureData.const_143);
         updateCategoryData(FigureData.const_137);
      }
      
      public function getCategoryContent(param1:String) : CategoryData
      {
         return var_306[param1];
      }
      
      public function dispose() : void
      {
         reset();
      }
      
      private function initCategory(param1:String) : void
      {
         var _loc2_:CategoryData = var_306[param1];
         if(_loc2_ == null)
         {
            var_306[param1] = _controller.generateDataContent(this,param1);
            updateCategoryData(param1);
         }
      }
      
      private function updateCategoryData(param1:String) : void
      {
         var _loc2_:int = _controller.figureData.getPartSetId(param1);
         var _loc3_:int = _controller.figureData.getColourId(param1);
         var _loc4_:CategoryData = var_306[param1];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.selectItemWithId(_loc2_);
         _loc4_.selectColourWithId(_loc3_);
      }
      
      public function toggleColourSelection(param1:String, param2:int) : void
      {
         var _loc3_:CategoryData = var_306[param1];
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.selectColour(param2);
         _controller.figureData.savePartSetColourId(param1,_loc3_.currentColourId,true);
      }
   }
}
