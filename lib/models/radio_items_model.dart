
class RadioItem {
  final String value;
  final bool isText; // Indicates whether the item is text or an image

  RadioItem.text(this.value) : isText = true;

  RadioItem.image(this.value) : isText = false;
}

