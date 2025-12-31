import java.util.Date;

int resizefactor=1; //Edit the image resizing value to avoid hanging pixels
String path = "kitchen"; //Root directory of input images
int r=50;  //Sampling radius
  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    return null;
  }
} 
void setup() {
  size(100,100);
  String[] filenames = listFileNames("./"+path);
  File[] files = listFiles("./"+path);
  println("In total "+files.length+" files");
  for (int i = 0; i < files.length; i++) {
    File f = files[i];    
    int UserFileNameStringLength = f.getName().length();
    String extension = f.getName().substring(UserFileNameStringLength-3);
    if(f.getName().endsWith("jpg")||f.getName().endsWith("png")||f.getName().endsWith("bmp")
      ||f.getName().endsWith("JPG")||f.getName().endsWith("PNG")||f.getName().endsWith("BMP"))
    {
      PImage im=loadImage(path+"/"+f.getName());
      PImage imo= loadImage(path+"/"+f.getName());
      im.resize(im.width*resizefactor,im.height*resizefactor);
      PImage im1=createImage(im.width,im.height,RGB);
      
          for(int j=0;j<im.width;j++)
      for(int k=0;k<im.height;k++)
        if(im.get(j,k)==color(255))
          if(j==0||k==0||j==im.width-1||k==im.height-1){ 
            im.set(j,k,color(0));
          }
      
      for(int j=0;j<im.width;j++)
        for(int k=0;k<im.height;k++)
          im1.set(j,k,color(255));
      for(int j=0;j<im.width;j++)
        for(int k=0;k<im.height;k++)
          if(red(im.get(j,k))>100)
            im.set(j,k,color(255));
          else
            im.set(j,k,color(0));
      for(int j=1;j<im.width-1;j++)
        for(int k=1;k<im.height-1;k++){
          if(im.get(j,k)==color(255)){
            if(red(im.get(j-1,k-1))<50||red(im.get(j-1,k))<50||red(im.get(j,k-1))<50||
              red(im.get(j+1,k-1))<50||red(im.get(j-1,k+1))<50||red(im.get(j+1,k))<50||
              red(im.get(j,k+1))<50||red(im.get(j+1,k+1))<50){
          im1.set(j,k,color(0));
        }
        else
        im1.set(j,k,color(255));
      }
    }
    int wid=im.width;
    int hei=im.height;
    PImage imb=createImage(wid,hei,RGB);
    for(int j=0;j<im.width;j++)
        for(int k=0;k<im.height;k++)
        imb.set(j,k,im1.get(j,k));
     PGraphics pim1,pim2;
     int[][] samples=new int[10000][2];
     int samplesi=0;
     pim1=createGraphics(im.width,im.height);
      pim2=createGraphics(im.width,im.height);
       pim1.beginDraw();
       pim1.background(255);
       pim1.stroke(0);
       pim1.fill(0);
       
        pim2.beginDraw();
      pim2.background(255);
     pim2.stroke(0);
      pim2.fill(255);

       for(int j=0;j<im.width;j++)
       for(int k=0;k<im.height;k++)
       {
         if(red(im1.get(j,k))<200)
         {
           for(int k1=j-(r/2);k1<j+(r/2);k1++)
           for(int k2=k-(r/2);k2<k+(r/2);k2++)
           {
             if(k1>=0&&k2>=0&&k1<im.width&&k2<im.height)
               if(distance(j,k,k1,k2)<r/2.0)
                 im1.set(k1,k2,color(255));
           }
           samples[samplesi][0]=j;
           samples[samplesi][1]=k;
           samplesi++;
             pim2.set(j,k,color(0));
          pim1.ellipse(j,k,20,20);
           im1.set(j,k,color(0,0,0));
         }
       }

       pim1.endDraw();
          pim2.endDraw();
         int startx=samples[1][0];
        int starty=samples[1][1];
        imb.set(startx,starty,color(255));
        int[][] gta=new int[100000][2];
        int gtai=1;
        gta[0][0]=startx;
        gta[0][1]=starty;
        while(true)
        {
          int fl=0;
          imb.set(startx,starty,color(255));
          if(red(imb.get(startx,starty-1))<150)
          {
            starty--;
            fl=1;
          }
          else
              if(red(imb.get(startx,starty+1))<150)
          {
            starty++;
            fl=1;
          }
          else
              if(red(imb.get(startx-1,starty))<150)
          {
            startx--;
            fl=1;
          }
          else
              if(red(imb.get(startx+1,starty))<150)
          {
            startx++;
            fl=1;
          }
          else
              if(red(imb.get(startx-1,starty-1))<150)
          {
            startx--;
            starty--;
            fl=1;
          }
           else
              if(red(imb.get(startx-1,starty+1))<150)
          {
            startx--;
            starty++;
            fl=1;
          }
           else
              if(red(imb.get(startx+1,starty-1))<150)
          {
            startx++;
            starty--;
            fl=1;
          }
           else
              if(red(imb.get(startx+1,starty+1))<150)
          {
            startx++;
            starty++;
            fl=1;
          }
          if(fl==0)
          break;
          if(pim2.get(startx,starty)==color(0))
          {
              gta[gtai][0]=startx;
        gta[gtai][1]=starty;
        gtai++;
          }
        }
       if(gtai>samplesi-10)
       {
                PrintWriter op;
       op = createWriter("./"+path+"Points_"+resizefactor+"_"+r+"/"+f.getName()+".txt"); 
       for(int i1=0;i1<samplesi;i1++)
                  op.println(samples[i1][0]+" "+samples[i1][1]);               
      op.flush();
      op.close();
      PrintWriter op1 = createWriter(path+"OrderedVertices_"+resizefactor+"_"+r+"/"+f.getName()+".txt");
      for(int i1=0;i1<gtai;i1++)
      op1.println(gta[i1][0]+" "+gta[i1][1]);
              op1.flush();
        op1.close();
       }
    }
  }
  exit();
}
double distance(int x1,int y1,int x2,int y2)
{
  return sqrt(sq(x2-x1)+sq(y2-y1));
}
