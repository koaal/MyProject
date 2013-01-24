package com.abc.myproject.common;

import java.net.URL;
import java.net.URLClassLoader;

public class ClassLoaderUtils {


    public static void main(String[] args) throws Exception {
    	ClassLoaderUtils.printClassloaders(ClassLoaderUtils.class);
    	ClassLoaderUtils.printClassLoaderHierarchy(ClassLoaderUtils.class);

    }

    public static void printClassloaders(@SuppressWarnings("rawtypes") Class clazz) {
        ClassLoader classLoader = clazz.getClassLoader();
        System.out.println("==============================");
        System.out.println("Class name:" + clazz.getName());
        printCLtree(classLoader, "");
        System.out.println("Thread.currentThread().getClass().getClassLoader():");
        ClassLoader cl = Thread.currentThread().getClass().getClassLoader();
        printCLtree(cl, "");
        System.out.println("==============================");
    }

    public static void printCLtree(ClassLoader cl, String indent) {
        if (cl == null) {
            return;
        }
        System.out.println(indent + "ClassLoader=" + cl);
        ClassLoader pcl = cl.getParent();
        if (pcl == null) {
            System.out.println(indent + "  ClassLoader=" + pcl);
        } else {
            printCLtree(pcl, indent + "  ");
        }
    }

    public static void printClassLoaderHierarchy(@SuppressWarnings("rawtypes") Class c) {
        ClassLoader cl = c.getClassLoader();
        System.out.println("================START================");
        System.out.println("\nClass loader tree");
        printClassLoaderTree(cl);
        System.out.println("\nContext loader tree");
        ClassLoader l = Thread.currentThread().getContextClassLoader();
        printClassLoaderTree(l);
        System.out.println("=================END=================");
    }

    public static void printClassLoaderTree(ClassLoader l) {
        ClassLoader p = l.getParent();
        if (p != null)
            printClassLoaderTree(p);
        String u = "";
        if (l instanceof URLClassLoader){
            u = getURLs(((URLClassLoader) l).getURLs());
        }
        System.out.println((new StringBuilder("\t|\n")).append(l).append(" ").append(u).toString());
    }

    //URLClassLoader for weblogic server
    public static String getURLs(URL urls[]) {
        if (urls == null)
            return "{}";
        StringBuffer b = new StringBuffer("{");
        for (int i = 0; i < urls.length; i++)
            b.append(urls[i]).append(":");

        b.append("}");
        return b.toString();
    }	
	
}
