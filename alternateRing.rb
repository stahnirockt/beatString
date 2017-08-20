class ::SonicPi::Core::RingVector
  
  # recursive function to get the rigth nested element of the ring,
  # based on the actual "look-Value" and divisorValue and check
  # if this element is another Ring (start recursion) or an array,
  # or just an single element
  def check_ringelement (ringElement, lookValue, oldDivisor)
    newDivisor = oldDivisor * ringElement.length
    actualElement = ringElement[(lookValue/oldDivisor).to_i]
    if actualElement.kind_of?(SonicPi::Core::RingVector)
      check_ringelement(actualElement, lookValue, newDivisor)
    elsif actualElement.kind_of?(Array)
      check_array(actualElement, lookValue, oldDivisor)
    else
      actualElement
    end
  end
  
  # recursive function to check if array contains a new ring,
  # or another array or just single elements
  def check_array (ringElement, lookValue, oldDivisor)
    ringElement.map do |n|
      if n.kind_of?(SonicPi::Core::RingVector)
        check_ringelement(n, lookValue, oldDivisor)
      elsif n.kind_of?(Array)
        check_array(n, lookValue, oldDivisor)
      else
        n
      end
    end
  end
  
  #'Main'-function to alternete Returnvalues of Rings
  def alternate(lookValue = look)
    #map over Ring and Check if element is a new ring or just an element in the ring.
    newRing = self.map do |element|
      if element.kind_of?(SonicPi::Core::RingVector)
        #if the element is a new ring, call this function
        check_ringelement(element, lookValue, self.length)
      elsif element.kind_of?(Array)
        check_array(element, lookValue, self.length)
      else
        element # if its just an element, nothing has to change
      end
    end
    newRing[lookValue]
  end
end
