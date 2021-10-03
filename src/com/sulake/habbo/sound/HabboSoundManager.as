package com.sulake.habbo.sound
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.SoundSettingsEvent;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
   import com.sulake.habbo.communication.messages.outgoing.sound.SetSoundSettingsComposer;
   import com.sulake.habbo.communication.messages.parser.sound.SoundSettingsParser;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomObjectSoundMachineStateUpdateEvent;
   import com.sulake.habbo.sound.object.HabboSound;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDRoomEngine;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import iid.IIDHabboWindowManager;
   
   public class HabboSoundManager extends Component implements IHabboSoundManager
   {
       
      
      private var _connection:IConnection;
      
      private var var_1365:Map;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1812:Boolean;
      
      private var var_160:IHabboConfigurationManager;
      
      private var var_600:Number = 1;
      
      public function HabboSoundManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var_1365 = new Map();
         super(param1,param2,param3);
         queueInterface(new IIDHabboConfigurationManager(),onHabboConfigurationInit);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationManagerReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         Logger.log("Sound manager 9 init");
      }
      
      public function set previewVolume(param1:Number) : void
      {
         updateVolumeSetting(param1);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 == null)
         {
            return;
         }
         _windowManager = IHabboWindowManager(param2);
      }
      
      private function onConnectionReady(param1:IConnection) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
            _connection = param1;
         }
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 == null)
         {
            return;
         }
         _roomEngine = IRoomEngine(param2);
         _roomEngine.events.addEventListener(RoomObjectSoundMachineStateUpdateEvent.const_832,onPlayEvent);
      }
      
      private function storeVolumeSetting() : void
      {
         if(_connection != null)
         {
            _connection.send(new SetSoundSettingsComposer(int(var_600 * 100)));
         }
      }
      
      private function onCommunicationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 != null)
         {
            _communication = IHabboCommunicationManager(param2);
            _communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(onAuthenticationOK));
         }
      }
      
      private function onAuthenticationOK(param1:IMessageEvent) : void
      {
         var _loc2_:IConnection = _communication.getHabboMainConnection(onConnectionReady);
         if(_loc2_ != null)
         {
            _loc2_.addMessageEvent(new SoundSettingsEvent(onSoundSettingsEvent));
            _loc2_.send(new GetSoundSettingsComposer());
            onConnectionReady(_loc2_);
         }
      }
      
      private function updateVolumeSetting(param1:Number) : void
      {
         var_600 = param1 * 1;
      }
      
      public function get volume() : Number
      {
         return var_600;
      }
      
      public function loadSoundUrl(param1:String) : IHabboSound
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:Sound = new Sound();
         _loc3_.load(_loc2_);
         var _loc4_:HabboSound = new HabboSound(_loc3_);
         _loc4_.volume = var_600;
         return _loc4_ as IHabboSound;
      }
      
      private function onPlayEvent(param1:Event) : void
      {
         var e:Event = param1;
         if(!var_1812)
         {
            if(_windowManager != null)
            {
               _windowManager.alertWithLink("${soundmachine.flash9.alert.title}","${soundmachine.flash9.alert.content}","${soundmachine.flash9.link.title}","http://get.adobe.com/flashplayer/",0,function(param1:IAlertDialog, param2:Event):void
               {
                  param1.dispose();
               });
               var_1812 = true;
            }
         }
      }
      
      private function onHabboConfigurationInit(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 != null)
         {
            var_160 = param2 as IHabboConfigurationManager;
         }
      }
      
      public function loadTraxSong(param1:int, param2:String) : IHabboSound
      {
         Logger.log("Trax playback is only available when running on Flash 10");
         return null;
      }
      
      public function set volume(param1:Number) : void
      {
         updateVolumeSetting(param1);
         storeVolumeSetting();
      }
      
      private function onSoundSettingsEvent(param1:IMessageEvent) : void
      {
         var _loc2_:SoundSettingsEvent = param1 as SoundSettingsEvent;
         var _loc3_:SoundSettingsParser = _loc2_.getParser() as SoundSettingsParser;
         if(_loc3_.volume == 1 || _loc3_.volume == 0)
         {
            updateVolumeSetting(_loc3_.volume * 1);
         }
         else
         {
            updateVolumeSetting(_loc3_.volume / 100);
         }
      }
      
      public function playSound(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:HabboSound = var_1365.getValue(param1);
         if(_loc2_ == null)
         {
            _loc3_ = "";
            switch(param1)
            {
               case HabboSoundTypesEnum.const_823:
                  _loc3_ = "sound_call_for_help";
                  break;
               case HabboSoundTypesEnum.const_1060:
                  _loc3_ = "sound_guide_received_invitation";
                  break;
               case HabboSoundTypesEnum.const_1255:
                  _loc3_ = "sound_console_new_message";
                  break;
               case HabboSoundTypesEnum.const_1128:
                  _loc3_ = "sound_message_sent";
                  break;
               case HabboSoundTypesEnum.const_912:
                  _loc3_ = "sound_catalogue_pixels";
                  break;
               case HabboSoundTypesEnum.const_737:
                  _loc3_ = "sound_catalogue_cash";
                  break;
               case HabboSoundTypesEnum.const_1239:
                  _loc3_ = "sound_respect_received";
                  break;
               default:
                  Logger.log("HabboSoundManager: Unknown sound request: " + param1);
            }
            _loc4_ = _assets.getAssetByName(_loc3_);
            _loc5_ = _loc4_.content as Sound;
            if(_loc5_ == null)
            {
               return;
            }
            _loc2_ = new HabboSound(_loc5_);
            var_1365.add(param1,_loc2_);
         }
         _loc2_.volume = var_600;
         _loc2_.play();
      }
   }
}
