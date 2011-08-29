﻿
class WebHelp

  def splitPathAndFile (strWebHelp)

    #split a dir + file string into dir and file and return them

    #get the file name from the end of the string, by:
    #putting the string into an array,
    aWebHelp = strWebHelp.split("/")
  
    #then getting the last element (i.e. the file name).
    strFile = aWebHelp[aWebHelp.length-1]
  
    #now get rid of the last element (the file name) from the array,
    aWebHelp.delete_at(aWebHelp.length-1)
  
    #then build a string from what's left (to give the path)
    strPath = aWebHelp.join("/")
  
    return strPath, strFile
  
  end
  
  
  def removeFileExtension (strFile)

    return File.basename(strFile)

  end
 
end

class GAProcessor

  def initialize
  
    @TRACKING_SCRIPT = File.read("files/ga/ga_tracking_script.txt")
  rescue
    puts "Couldn't open  GA tracking file."
	abort
  end
  
  def addTrackingCode (htmlFile)
  
    htmlFile['</head>'] = @TRACKING_SCRIPT
	#puts "Added tracking code to: " + @TRACKING_SCRIPT
  
  end


end

class FeedbackFormProcessor

  def setFeedbackForm (lang)
  
    @FEEDBACK_FORM = File.read("files/ff/" + lang.downcase + "_help_feedback_form.htm")
    #update the product name.
    @FEEDBACK_FORM["<medidata-product-name>"] = $hSettings["product"]
  
  end
  
  def copyFormGraphics (strWebHelpImagesFolder)
  
    FileUtils.cp "files/ff/star_on.jpg", strWebHelpImagesFolder + "star_on.jpg"
    FileUtils.cp "files/ff/star_on_almost.jpg", strWebHelpImagesFolder + "star_on_almost.jpg"
    FileUtils.cp "files/ff/star_off.jpg", strWebHelpImagesFolder + "star_off.jpg"
    FileUtils.cp "files/ff/star_hover.jpg", strWebHelpImagesFolder + "star_hover.jpg"
    FileUtils.cp "files/ff/star_hover_almost.jpg", strWebHelpImagesFolder + "star_hover_almost.jpg"
  
  end
  
  def addFeedbackForm (strHTMLFile)
  
    strHTMLFile['</body>'] = @FEEDBACK_FORM
  
  end


end

def writeFile(fileInWebHelp, strHTMLFile)

    fTaggedFile = File.open(fileInWebHelp, 'w')
    fTaggedFile.write (strHTMLFile)
    fTaggedFile.close

end

def openFile(fileInWebHelp)

  begin
    return File.read(fileInWebHelp)
  rescue
    puts "Couldn't open " + fileInWebHelp
  end

end