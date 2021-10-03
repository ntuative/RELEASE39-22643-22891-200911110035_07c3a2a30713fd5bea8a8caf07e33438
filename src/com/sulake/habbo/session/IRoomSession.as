package com.sulake.habbo.session
{
   public interface IRoomSession
   {
       
      
      function sendPollRejectMessage(param1:int) : void;
      
      function sendPollAnswerMessage(param1:int, param2:int, param3:Array) : void;
      
      function get isPrivateRoom() : Boolean;
      
      function changeQueue(param1:int) : void;
      
      function set isRoomController(param1:Boolean) : void;
      
      function get roomResources() : String;
      
      function letUserIn(param1:String, param2:Boolean) : void;
      
      function sendPollStartMessage(param1:int) : void;
      
      function sendWhisperMessage(param1:String, param2:String) : void;
      
      function get isRoomOwner() : Boolean;
      
      function quit() : void;
      
      function set isSpectatorMode(param1:Boolean) : void;
      
      function sendPresentOpenMessage(param1:int) : void;
      
      function sendVote(param1:int) : void;
      
      function get roomId() : int;
      
      function get state() : String;
      
      function get isTradingRoom() : Boolean;
      
      function sendRoomDimmerChangeStateMessage() : void;
      
      function set isRoomOwner(param1:Boolean) : void;
      
      function sendShoutMessage(param1:String) : void;
      
      function get userDataManager() : IUserDataManager;
      
      function kickBot(param1:int) : void;
      
      function start() : Boolean;
      
      function set isTradingRoom(param1:Boolean) : void;
      
      function sendWaveMessage() : void;
      
      function sendChatMessage(param1:String) : void;
      
      function get isRoomController() : Boolean;
      
      function sendSignMessage(param1:int) : void;
      
      function assignRights(param1:int) : void;
      
      function sendCreditFurniRedeemMessage(param1:int) : void;
      
      function get isSpectatorMode() : Boolean;
      
      function sendChatTypingMessage(param1:Boolean) : void;
      
      function kickUser(param1:int) : void;
      
      function sendRoomDimmerGetPresetsMessage() : void;
      
      function sendRoomDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean) : void;
      
      function get roomCategory() : int;
      
      function banUser(param1:int) : void;
      
      function removeRights(param1:int) : void;
      
      function sendDanceMessage(param1:int) : void;
   }
}
