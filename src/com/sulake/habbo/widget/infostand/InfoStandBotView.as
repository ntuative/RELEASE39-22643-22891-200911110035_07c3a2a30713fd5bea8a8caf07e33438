package com.sulake.habbo.widget.infostand
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetUserActionMessage;
   
   public class InfoStandBotView extends InfoStandUserView
   {
       
      
      public function InfoStandBotView(param1:InfostandWidget, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function updateButtons(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         showButton("friend",false);
         showButton("respect",false);
         showButton("ignore",false);
         showButton("unignore",false);
         showButton("kick",param1.canBeKicked);
         showButton("ban",false);
         showButton("whisper",false);
         updateRightsButton(false,false);
         showButton("trade",false);
         showButton("report",false);
         if(param1.canBeKicked)
         {
            var_63.visible = true;
         }
         else
         {
            var_63.visible = false;
         }
      }
      
      override public function update(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         clearBadges();
         setTags([]);
         updateButtons(param1);
         updateInfo(param1);
         updateWindow();
      }
      
      override protected function createWindow(param1:String, param2:Boolean) : void
      {
         super.createWindow(param1,true);
      }
      
      override protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindow = param1.target as IWindow;
         if(_loc2_.name == "kick")
         {
            _loc3_ = _widget.userData.userRoomId;
            _widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.const_436,_loc3_));
         }
      }
   }
}
