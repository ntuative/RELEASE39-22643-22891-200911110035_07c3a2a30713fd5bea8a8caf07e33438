package com.sulake.habbo.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.avatar.wardrobe.Outfit;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.avatar.GetWardrobeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
   
   public class AvatarEditorHandler
   {
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var _controller:HabboAvatarEditor;
      
      public function AvatarEditorHandler(param1:HabboAvatarEditor, param2:IHabboCommunicationManager)
      {
         super();
         _controller = param1;
         _communication = param2;
         _communication.addHabboConnectionMessageEvent(new WardrobeMessageEvent(onWardrobe));
         _communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(onAuthenticationOK));
         _communication.addHabboConnectionMessageEvent(new UserChangeMessageEvent(onUserChange));
      }
      
      public function saveCurrentSelection() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:String = _controller.figureData.getFigureString();
         var _loc2_:String = _controller.figureData.gender;
         var _loc3_:* = new UpdateFigureDataMessageComposer(_loc1_,_loc2_);
         _communication.getHabboMainConnection(null).send(_loc3_);
         _loc3_.dispose();
         _loc3_ = null;
      }
      
      private function onUserChange(param1:UserChangeMessageEvent) : void
      {
      }
      
      public function getWardrobe() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:* = new GetWardrobeMessageComposer();
         _communication.getHabboMainConnection(null).send(_loc1_);
         _loc1_.dispose();
         _loc1_ = null;
      }
      
      private function onAuthenticationOK(param1:IMessageEvent) : void
      {
      }
      
      private function onWardrobe(param1:WardrobeMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         _controller.wardrobe.updateMyLooks(param1.state,param1.outfits);
      }
      
      public function saveWardrobeOutfit(param1:int, param2:Outfit) : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc3_:* = new SaveWardrobeOutfitMessageComposer(param1,param2.figure,param2.gender);
         _communication.getHabboMainConnection(null).send(_loc3_);
         _loc3_.dispose();
         _loc3_ = null;
      }
      
      public function selectWardrobeOutfit(param1:int) : void
      {
      }
   }
}
