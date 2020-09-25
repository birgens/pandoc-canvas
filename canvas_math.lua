i = 1

function Math(elem)
   latex_text = ""
   if elem.mathtype == "DisplayMath" then
      latex_text = elem.text:gsub("\\","\\\\") .. "\\tag{" .. i .. "}"
      i = i + 1
   else
      latex_text = elem.text:gsub("\\","\\\\")
   end
   local handle = io.popen("urlencode \"" .. latex_text .. "\"")
   local encoded_text = handle:read("*a")
   handle:close()

   image = pandoc.Image("LaTex: " .. latex_text, "https://uit.instructure.com/equation_images/" .. encoded_text)
   image.title = latex_text
   image.classes = {"equation_image"}

   image.attr.attributes = {["data-equation-content"] = latex_text}
   if elem.mathtype == "DisplayMath" then
      return {pandoc.LineBreak(),image,pandoc.LineBreak()}
   else
      return image
   end
   
end
