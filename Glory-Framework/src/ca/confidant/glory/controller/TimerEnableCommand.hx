﻿package ca.confidant.glory.controller;    import org.puremvc.haxe.patterns.command.SimpleCommand;	import org.puremvc.haxe.interfaces.INotification;    import ca.confidant.glory.ApplicationFacade;	import ca.confidant.glory.ApplicationFacade;	import ca.confidant.glory.model.TickerProxy;	import ca.confidant.glory.model.PagesConfigProxy;    class TimerEnableCommand extends SimpleCommand    {/** * This command exists to start ticker-style events, which are useful for map-panning, etc. */        override public function execute( note:INotification ) : Void        {			//trace('TimerEnableCommand');			var p: TickerProxy;			if(!facade.hasProxy(TickerProxy.NAME)){				//trace("making a tickerProxy");				p=new TickerProxy();				facade.registerProxy(p);			} else {				//trace("already a tickerProxy");				p=cast(facade.retrieveProxy(TickerProxy.NAME),TickerProxy);			}			var interval=cast(note.getBody(),Int);			p.startTimer(interval);        }    }