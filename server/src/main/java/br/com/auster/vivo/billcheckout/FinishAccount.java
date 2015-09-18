// Decompiled by Jad v1.5.8f. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ListenerClient.java

package br.com.auster.vivo.billcheckout;

import java.util.Properties;

import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import br.com.auster.dware.console.listener.RequestFinished;

public class FinishAccount
{

    public FinishAccount()
    {
    }

    public static void main(String args[])
    {
        try
        {
            if(args.length < 5)
            {
                System.out.println("Usage> " + FinishAccount.class.getSimpleName() + " <requestId> <accountId> <status> <message> <T3-URL>");
                System.exit(1);
            }
            Context jndiContext = getInitialContext(args[4]);
            QueueConnectionFactory ref = (QueueConnectionFactory)jndiContext.lookup("billcheckout/QueueConnectionFactory");
            Queue queue = (Queue)jndiContext.lookup("queue/procNotification");
            QueueConnection queueConnection = ref.createQueueConnection();
            QueueSession queueSession = queueConnection.createQueueSession(false, 1);
            QueueSender queueSender = queueSession.createSender(queue);
            ObjectMessage msg = queueSession.createObjectMessage();
            long id = Long.parseLong(args[0]);
            String accId = args[1].trim();
            int status = Integer.parseInt(args[2]);
            String msgText = args[3].trim();
            System.out.println("Seding message for requestId = " + id + " accountId = '" + accId + " status = " + status + " message = '" + msg + "'");
            msg.setObject(createFinishObject(id, accId, status, msgText));
            queueConnection.start();
            queueSender.send(msg);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public static Context getInitialContext(String t3Url)
        throws NamingException
    {
        Properties p = new Properties();
        p.put("java.naming.factory.initial", "weblogic.jndi.WLInitialContextFactory");
        p.put("java.naming.provider.url", t3Url);
        return new InitialContext(p);
    }

    public static RequestFinished createFinishObject(long _requestId, String _accountId, int _status, String _message)
    {
        RequestFinished finished = new RequestFinished();
        finished.setRequestId(_requestId);
        finished.setAccountId(_accountId);
        finished.setStatus(_status);
        finished.setMessage(_message);
        return finished;
    }
}
