import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.util.Enumeration;

/**
 https://stackoverflow.com/questions/9481865/getting-the-ip-address-of-the-current-machine-using-java
 */
private InetAddress getLocalHostLANAddress() throws UnknownHostException {
  try {
    InetAddress candidateAddress = null;
    // Iterate all NICs (network interface cards)...
    for (Enumeration ifaces = NetworkInterface.getNetworkInterfaces(); ifaces.hasMoreElements(); ) {
      NetworkInterface iface = (NetworkInterface) ifaces.nextElement();
      // Iterate all IP addresses assigned to each card...
      for (Enumeration inetAddrs = iface.getInetAddresses(); inetAddrs.hasMoreElements(); ) {
        InetAddress inetAddr = (InetAddress) inetAddrs.nextElement();
        if (!inetAddr.isLoopbackAddress()) {
          
          // -84 == 172 ?? docker address on my comp uses 172.x.0.1
          if (inetAddr.isSiteLocalAddress() && inetAddr.getAddress()[0] != -84) {
            // Found non-loopback site-local address. Return it immediately...
            return inetAddr;
          } else if (candidateAddress == null) {
            // Found non-loopback address, but not necessarily site-local.
            // Store it as a candidate to be returned if site-local address is not subsequently found...
            candidateAddress = inetAddr;
            // Note that we don't repeatedly assign non-loopback non-site-local addresses as candidates,
            // only the first. For subsequent iterations, candidate will be non-null.
          }
        }
      }
    }

    if (candidateAddress != null) {
      // We did not find a site-local address, but we found some other non-loopback address.
      // Server might have a non-site-local address assigned to its NIC (or it might be running
      // IPv6 which deprecates the "site-local" concept).
      // Return this non-loopback candidate address...
      return candidateAddress;
    }
    // At this point, we did not find a non-loopback address.
    // Fall back to returning whatever InetAddress.getLocalHost() returns...
    InetAddress jdkSuppliedAddress = InetAddress.getLocalHost();
    if (jdkSuppliedAddress == null) {
      throw new UnknownHostException("The JDK InetAddress.getLocalHost() method unexpectedly returned null.");
    }
    return jdkSuppliedAddress;
  } 
  catch (Exception e) {
    UnknownHostException unknownHostException = new UnknownHostException("Failed to determine LAN address: " + e);
    unknownHostException.initCause(e);
    throw unknownHostException;
  }
}

String getIP() {
  InetAddress localhostIP = null;

  try {
    localhostIP = getLocalHostLANAddress();
  } 
  catch (UnknownHostException ex) {
    println("Where you at?");
  }

  if (localhostIP != null) {
    return localhostIP.getHostAddress();
  } else {
    return null; 
  }  
}


int[] ipParts(String ipString) {
  String[] split = ipString.split("\\.");
  int[] ret = new int[split.length];
  for (int i = 0; i < split.length; i++) {
    ret[i] = parseInt(split[i]);
  }
  return ret;
}