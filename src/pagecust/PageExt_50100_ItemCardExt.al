pageextension 50100 "ItemCArdExtension" extends "Item Card"
{
    actions
    {
        addlast(ItemActionGroup)
        {
            group(Picture)
            {
                action(CreatePicture)
                {
                    Caption = 'Create Item Image by Description';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = Picture;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Clear(SerchImageOpenAPI);
                        Base64text := SerchImageOpenAPI.CreateImgOpenAI(Rec.Description);

                        TempBlob.CreateOutStream(outstream);
                        base64convert.FromBase64(Base64text, outstream);
                        TempBlob.CreateInStream(InStream);

                        Clear(rec.Picture);
                        Rec.Picture.ImportStream(instream, '');
                        Rec.Modify()

                    end;
                }
            }
        }
    }
    var
        SerchImageOpenAPI: Codeunit SerchImageOpenAPI;
        FromText: Text;
        Base64text: Text;
        base64convert: codeunit "Base64 Convert";
        newItem: Record Item;
        TempBlob: Codeunit "Temp Blob";
        outstream: OutStream;
        instream: InStream;
}