package es.uam.eps.das.exe4.handler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IConfigurationElement;
import org.eclipse.core.runtime.IExtensionRegistry;
import org.eclipse.core.runtime.ILog;
import org.eclipse.core.runtime.Platform;
import org.eclipse.core.runtime.Status;
import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.handlers.HandlerUtil;
import org.osgi.framework.Bundle;

import es.uam.eps.das.exe4.Activator;
import es.uam.eps.das.exe4.source.TipSource;

/**
 * Our sample handler extends AbstractHandler, an IHandler base class.
 * @see org.eclipse.core.commands.IHandler
 * @see org.eclipse.core.commands.AbstractHandler
 */
public class ButtonHandler extends AbstractHandler {
	
	private List<String> tips = new ArrayList<String>();
	private Random random = new Random();
	/**
	 * The constructor.
	 */
	public ButtonHandler() {
		//apartado 1
		Bundle bundle = Platform.getBundle("es.uam.eps.das.exe4");
		URL fileURL = bundle.getEntry("data/tips.txt");
		
		try {
		InputStream is = fileURL.openStream();
		BufferedReader in = new BufferedReader(new InputStreamReader(is));
		String tip;
		while ((tip = in.readLine()) != null) tips.add(tip);
			in.close();
			is.close();
		} catch (IOException e) { e.printStackTrace(); }
		
		//fin apartado 1
		
		//apartado 2
		IExtensionRegistry reg = Platform.getExtensionRegistry();
		IConfigurationElement[] extensions = reg.getConfigurationElementsFor("es.uam.eps.das.exe4.tipsource");
		for (IConfigurationElement e : extensions) {
		if (e.getName().equals("TipSource")) {
			try {
				TipSource source = (TipSource) e.createExecutableExtension("class");
				for (String tip : source.getTips()) {
					tips.add(tip);
				}
			} catch (CoreException e1) {
				Status status = new Status(Status.ERROR, Activator.PLUGIN_ID, "Expected ITipSource");
				ILog logger = Activator.getDefault().getLog();
				logger.log(status);
				}
			}
		}
	}
	
	/**
	 * the command has been executed, so extract extract the needed information
	 * from the application context.
	 */
	public Object execute(ExecutionEvent event) throws ExecutionException {
		IWorkbenchWindow window = HandlerUtil.getActiveWorkbenchWindowChecked(event);
		
		MessageDialog.openInformation(
				window.getShell(),
				"Tip of the day",
				tips.get(random.nextInt(tips.size())));
		return null;
	}
}
